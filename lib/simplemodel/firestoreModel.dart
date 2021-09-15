import 'package:chat_re/objects/chatroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreModel {
  ///firebaseインスタンス
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///モデル
  Future<void> searchUserList({required String userName}) async {
    QuerySnapshot _snapshot = await firestore
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();
  }
}
