import 'package:chat_re/objects/chatroom.dart';
import 'package:chat_re/objects/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirestoreModel {
  ///firebaseインスタンス
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool hitTheBottom = false;
  QueryDocumentSnapshot? lastVisible;
  List<UserData> userList = [];

  ///モデル
  Future<List<UserData>> searchUserList({required String userName}) async {
    final snapshot = await firestore
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();
    print(snapshot);

    //取得件数０だったらリターン（snapshots.docs[ここがマイナスになったら怒られる]）
    if (snapshot.docs.isEmpty) {
      print('first get nothing');
      hitTheBottom = true;
      return userList;
    }
    lastVisible = snapshot.docs[snapshot.docs.length - 1];
    // ignore: join_return_with_assignment
    userList = snapshot.docs.map((doc) => UserData(doc)).toList();
    return userList;
  }

  ///メッセージを送る
  Future<void> postMessage({required String friendId,
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

  Future<void> setFriendList({required String friendId,
    required String friendName,
    required String message}) async {
    ///UserData型からiconUrlをとってくる
    ///自分
    final _myPath = firestore
        .collection('users')
        .where('userId', isEqualTo: auth.currentUser!.uid);
    final _myDoc = await _myPath.get();
    final _myUrlList = _myDoc.docs.map((e) => e.data()['iconUrl']).toList();
    final _myIconUrl = _myUrlList[0];

    ///相手
    final _friendPath =
    firestore.collection('users').where('userId', isEqualTo: friendId);
    final _friendDoc = await _friendPath.get();
    final _friendIconUrlList =
    _friendDoc.docs.map((e) => e.data()['iconUrl']).toList();
    final _friendIconUrl = _friendIconUrlList[0];

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chatroom')
        .doc(friendId)
        .set(<String, dynamic>{
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'friendId': friendId,
      'friendName': friendName,
      'message': message,
      'friendIconUrl': _friendIconUrl,
    });

    await firestore
        .collection('users')
        .doc(friendId)
        .collection('chatroom')
        .doc(auth.currentUser!.uid)
        .set(<String, dynamic>{
      'createdAt': Timestamp.fromDate(DateTime.now()),
      'friendId': friendId,
      'friendName': friendName,
      'message': message,
      'friendIconUrl': _myIconUrl,
    });
  }

}
