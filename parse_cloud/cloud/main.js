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
