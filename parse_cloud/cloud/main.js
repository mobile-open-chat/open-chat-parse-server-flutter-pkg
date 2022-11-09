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
