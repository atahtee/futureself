const {onSchedule} = require("firebase-functions/v2/scheduler");
const {setGlobalOptions} = require("firebase-functions/v2");
const admin = require("firebase-admin");

admin.initializeApp();

setGlobalOptions({region: "us-central1"});

exports.scheduleNotifications = onSchedule(
  "every 24 hours",
  async (context) => {
    const now = new Date();
    const lettersSnapshot = await admin
      .firestore()
      .collection("letters")
      .where("deliveryDate", "<=", now)
      .get();

    if (lettersSnapshot.empty) {
      console.log("No letters to deliver today");
      return null;
    }

    const sendPromises = [];
    lettersSnapshot.forEach((doc) => {
      const letterData = doc.data();
      const fcmToken = letterData.fcmToken;
      const letterContent = letterData.letterContent;

      if (fcmToken) {
        const message = {
          token: fcmToken,
          notification: {
            title: "A message from your past Self!",
            body: letterContent,
          },
        };

        const sendPromise = admin
          .messaging()
          .send(message)
          .then((response) => {
            console.log(
              `Successfully sent notification to ${doc.id}:`,
              response,
            );
          })
          .catch((error) => {
            console.error(`Error sending  to ${doc.id}:`, error);
          });
        sendPromises.push(sendPromise);
      }
    });

    await Promise.all(sendPromises);
    return null;
  },
);
