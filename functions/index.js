// In functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendScheduledNotifications = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
  const now = admin.firestore.Timestamp.now();
  const startOfDay = new Date(now.toDate().setHours(0, 0, 0, 0));
  const endOfDay = new Date(now.toDate().setHours(23, 59, 59, 999));

  const querySnapshot = await admin.firestore().collection('letters')
    .where('deliveryDate', '>=', startOfDay)
    .where('deliveryDate', '<=', endOfDay)
    .get();

  const promises = querySnapshot.docs.map(async (doc) => {
    const userId = doc.data().userId;
    const userDoc = await admin.firestore().collection('users').doc(userId).get();
    const fcmToken = userDoc.data().fcmToken;

    if (fcmToken) {
      const message = {
        notification: {
          title: 'Your Letter Has Arrived!',
          body: 'A letter from your past self is ready to read.',
        },
        token: fcmToken,
      };

      return admin.messaging().send(message);
    }
  });

  await Promise.all(promises);
  console.log(`Sent notifications for ${promises.length} letters`);
  return null;
});