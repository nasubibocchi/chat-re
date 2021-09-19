/* eslint-disable */

// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

//push通知実行メソッド
const pushMessage = (fcmToken, text) => ({
    notification: {
        title: '新しいオファーを受信しました。',
        body: `${text}`,
    },
    apns: {
        headers: {
            'apns-priority': '10'
        },
        payload: {
            aps: {
                badge: 9999,
                sound: 'default'
            }
        }
    },
    data: {
        data: 'test',
    },
    token: fcmToken
});

///authenticationのuid
const auth = context.auth;
const uid = auth.uid;

///firestoreデータ
const tokenRef = functions.firestore.collection('users').document(uid);
const token = await tokenRef.get().docs.data()['fcmToken'];

const titleQuery = await functions.firestore.collection('users').document(uid).collection('chatroom').orderBy('createdAt').get();
const titleList = titleQuery.docs.map((e) => e.data()['message']);
const title = titleList[0]; ///onUpdateされたら一番最新のやつが通知されてOKと仮定（検証必要）

const checkIdList = titleQuery.docs.map((e) => e.data()['friendId']);
const checkId = checkIdList[0];

///function
exports.sendPush = functions.firestore
    .document('users/{userId}/chatroom/{friendId}')
    .onUpdate((change, context) => {
        ///最新メッセージが自分から送ったものでなければ通知実行
        if (checkId != uid) {
            admin.messaging().send(pushMessage(token, title));
        } 
    });

/* eslint-disable */