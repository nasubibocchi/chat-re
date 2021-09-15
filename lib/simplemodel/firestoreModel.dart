
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreModel {
  ///firebaseインスタンス
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///モデル
  Future<void> searchUserList({required String userName}) async {
    await firestore
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();
  }

  Future<void> postMessage(
      {required String friendId,
      required String friendName,
      required String message}) async {
    ///自分側
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chatroom')
        .doc(friendId)
        .collection('message')
        .doc(
          Timestamp.fromDate(DateTime.now()).toString(),
        )
        .set(<String, dynamic>{
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'userId': auth.currentUser!.uid,
      'userName': auth.currentUser!.displayName,
      'friendId': friendId,
      'friendName': friendName,
      'message': message,
    });

    ///相手側
    await firestore
        .collection('users')
        .doc(friendId)
        .collection('chatroom')
        .doc(auth.currentUser!.uid)
        .collection('message')
        .doc(
      Timestamp.fromDate(DateTime.now()).toString(),
    )
        .set(<String, dynamic>{
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'userId': auth.currentUser!.uid,
      'userName': auth.currentUser!.displayName,
      'friendId': friendId,
      'friendName': friendName,
      'message': message,
    });
  }

}
