import 'package:chat_re/objects/chatroom.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/appbar.dart';
import 'widgets/chat_room_list.dart';

class ChatRoomListPage extends StatelessWidget {
  const ChatRoomListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///firebaseデータの呼び出し用
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: myAppBar(title: 'チャットルーム一覧'),
      body: StreamBuilder(
          stream: firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .collection('chatroom')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (!snapshot.hasData) {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('ユーザーを探してみよう'),
              );
            } else {
              final _newSnapshot =
                  snapshot.data!.docs.map((e) => ChatRoom(e)).toList();
              return ListView.builder(
                  itemCount: _newSnapshot.length,
                  itemBuilder: (BuildContext context, int index) {
                    return chatRoomList(
                        context: context,
                        chatRoomList: _newSnapshot,
                        index: index);
                  });
            }
          }),
    );
  }
}
