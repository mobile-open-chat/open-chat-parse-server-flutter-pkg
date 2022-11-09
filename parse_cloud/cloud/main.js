const imageThumbnail = require("image-thumbnail");

const firebaseAdmin = require("firebase-admin");
const serviceAccount = require("./path/to/firebase/admin-sdk/credentials.json");
firebaseAdmin.initializeApp({
  credential: firebaseAdmin.credential.cert(serviceAccount),
});

Parse.Cloud.define("intiClientChatMessages", async (request) => {
  const user = request.user;
  let result = [];
  const chatUsers = await user
    .relation("chatUsersRelation")
    .query()
    .find({ sessionToken: user.getSessionToken() });

  for (let i = 0; i < chatUsers.length; i++) {
    const parseChatUser = chatUsers[i];

    const chatID = generateChatID(user.id, parseChatUser.id);

    const latestMessages = await getLatestMessages(
      chatID,
      user.getSessionToken(),
      user.id
    );

    const jsonChatUser = parseChatUser.toJSON();
    jsonChatUser["messages"] = latestMessages;
    result[i] = jsonChatUser;
  }

  return result;
});

/**
 * @param {String} chatID
 * @param {String} userID
 * @param {String} userSessionToken
 */
async function getLatestMessages(chatID, userSessionToken, userID) {
  let latestMessages = [];

  let messagesQuery = new Parse.Query("Messages");
  messagesQuery.equalTo("chatID", chatID);
  messagesQuery.descending("localSentDate");
  messagesQuery.limit(50);
  let messagesResults = await messagesQuery.find({
    sessionToken: userSessionToken,
  });

  if (messagesResults.length == 0) {
    return [];
  }

  if (
    isMessageSentByThisUser(userID, messagesResults[0]) ||
    isReceivedMessageDeliveryStateIsSeen(messagesResults[0])
  ) {
    return [messagesResults[0]];
  }

  for (const message of messagesResults) {
    if (
      isMessageSentByThisUser(userID, message) ||
      isReceivedMessageDeliveryStateIsSeen(message)
    ) {
      break;
    }

    latestMessages.push(message);
  }

  return latestMessages;
}

/**
 * @param {String} userID
 * @param {Parse.Object<Parse.Attributes>} message
 */
function isMessageSentByThisUser(userID, message) {
  return message.get("sender").id === userID;
}

/**
 * @param {Parse.Object<Parse.Attributes>} message
 */
function isReceivedMessageDeliveryStateIsSeen(message) {
  return message.get("messageDeliveryState") === "seen";
}

Parse.Cloud.beforeSave("Messages", async (request) => {
  let message = request.object;
  if (message.isNew()) {
    message.set("sender", request.user.toPointer());
    await checkIfTheSenderWasBlockedByReceiver(message);
    setChatIDForMessage(message);
    setMessageACL(message);

    if (message.get("messageType") === "image") {
      await createThumbnail(message);
    }
  }
});

/**
 * @param {Parse.Object<Parse.Attributes>} message
 */
function setChatIDForMessage(message) {
  const senderId = message.get("sender").id;
  const receiverId = message.get("receiver").id;
  const chatID = generateChatID(senderId, receiverId);

  message.set("chatID", chatID);
}

/**
 * @param {String} ID1 first id
 * @param {String} ID2 second id
 */
function generateChatID(ID1, ID2) {
  let chatID;
  if (ID1 > ID2) {
    chatID = ID1.concat(ID2);
  } else {
    chatID = ID2.concat(ID1);
  }

  return chatID;
}

async function checkIfTheSenderWasBlockedByReceiver(message) {
  const senderId = message.get("sender").id;
  const receiver = await message.get("receiver").fetch({ useMasterKey: true });

  let receiverBlockedUsersList = receiver.get("blockedUsersArray");
  if (receiverBlockedUsersList.includes(senderId)) {
    throw new Parse.Error(
      1000,
      "the sender user was blocked by the receiver user, can not send a message"
    );
  }
}

/**
 * @param {Parse.Object<Parse.Attributes>} message
 */
function setMessageACL(message) {
  const sender = message.get("sender");
  const receiver = message.get("receiver");

  let acl = new Parse.ACL();
  acl.setReadAccess(sender, true);
  acl.setWriteAccess(sender, true);

  acl.setReadAccess(receiver, true);
  acl.setWriteAccess(receiver, true);

  message.setACL(acl);
}

/**
 * @param {Parse.Object<Parse.Attributes>} message
 */
async function createThumbnail(message) {
  try {
    const image = message.get("file");
    const imageDate = await image.getData();

    const imageFileBuffer = Buffer.from(imageDate, "base64");

    const options = { percentage: 5, responseType: "base64" };
    const thumbnail = await imageThumbnail(imageFileBuffer, options);

    const thumbFile = new Parse.File(image.name(), { base64: thumbnail });

    const imageThumbnailFile = await thumbFile.save();

    message.set("thumbnail", imageThumbnailFile);
  } catch (error) {
    console.log("error while generating image thumbnail error:" + error);
  }
}

Parse.Cloud.afterSave("Messages", async (request) => {
  const message = request.object;
  sendPushNotificationToReceiver(message);
  const sender = await message.get("sender").fetch({ useMasterKey: true });
  const receiver = await message.get("receiver").fetch({ useMasterKey: true });

  addUser1ToChatUsersListForUser2(sender, receiver);
  addUser1ToChatUsersListForUser2(receiver, sender);
});

/**
 * @param {Parse.Object<Parse.Attributes>} user1
 * @param {Parse.Object<Parse.Attributes>} user2
 */
async function addUser1ToChatUsersListForUser2(user1, user2) {
  let user2ChatUsersList = user2.get("chatUsersArray");
  let isAlreadyAdded = user2ChatUsersList.includes(user1.id);
  if (isAlreadyAdded) {
    return;
  }
  user2.addUnique("chatUsersArray", user1.id);
  user2.relation("chatUsersArray").add(user1);
  await user2.save(null, { useMasterKey: true });
}

/**
 * @param {Parse.Object<Parse.Attributes>} message
 */
async function sendPushNotificationToReceiver(message) {
  let sender = await message.get("sender").fetch({ useMasterKey: true });
  let receiver = await message.get("receiver").fetch({ useMasterKey: true });

  let senderName = sender.get("name");
  let senderProfileImage = sender.get("profileImage");

  let textMessage = message.get("textMessage");
  let messageType = message.get("messageType");
  if (messageType === "image") {
    textMessage = "📷️ Image";
  }

  let options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
    contentAvailable: true,
  };

  let payload = {
    data: {
      messageType: messageType,
      senderName: senderName,
      textMessage: textMessage,
      senderId: sender.id,
    },
  };

  if (senderProfileImage != null) {
    payload.data["profileImageUrl"] = senderProfileImage.url();
  }

  let installationQuery = new Parse.Query(Parse.Installation);
  installationQuery.equalTo("user", receiver);

  installationQuery
    .find({ useMasterKey: true })
    .then((installations) => {
      for (const installation of installations) {
        let token = installation.get("deviceToken");

        if (token != null || token != "") {
          sendPushNotificationUsingFireBaseAdmin(token, payload, options);
        }
      }
    })
    .catch(function (error) {
      console.log(
        "messaging=>********** Got an error  while getting the installations for the receiver user:  " +
          receiver +
          +" error code:" +
          error.code +
          " , message: " +
          error.message
      );
    });
}

function sendPushNotificationUsingFireBaseAdmin(token, payload, options) {
  // If we receive either of these error code responses for a targeted token,
  // it is safe to delete the installation record of this token, since it will never again be valid
  const UNREGISTERED = "messaging/invalid-registration-token";
  const INVALID_ARGUMENT = "messaging/invalid-argument";
  const NOT_REGISTERED = "messaging/registration-token-not-registered";

  firebaseAdmin
    .messaging()
    .sendToDevice(token, payload, options)
    .then(function (response) {
      if (response.failureCount != 0) {
        let error = response.results[0].error;
        if (
          error.code == UNREGISTERED ||
          error.code == INVALID_ARGUMENT ||
          error.code == NOT_REGISTERED
        ) {
          deleteDeviceTokenFromInstallationRecord(token);
        } else {
          console.log(
            "messaging =>********** Got an error " +
              error.code +
              " : " +
              error.message
          );
        }
      }
    })
    .catch(function (error) {
      console.log(
        "messaging =>********** Got an error " +
          error.code +
          " : " +
          error.message
      );
    });
}
