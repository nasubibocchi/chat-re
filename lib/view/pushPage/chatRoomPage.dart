import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/objects/message.dart';
import 'package:chat_re/simplemodel/firestoreModel.dart';
import 'package:chat_re/view/weidgets/messageList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  ChatRoomPage({required this.friendId, required this.friendName});

  String friendId;
  String friendName;

  @override
  Widget build(BuildContext context) {
    ///firebase呼び出し用
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    ///モデル
    final _firestoreModel = FirestoreModel();

    ///テキストコントローラ
    TextEditingController _messageController = TextEditingController();

    ///変数
    String _messageText = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBaseColour,
        title: Text(friendName, style: TextStyle(color: kTextColour)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 10,
            child: StreamBuilder(
                stream: firestore
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .collection('chatroom')
                    .doc(friendId)
                    .collection('message')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('最初のメッセージを送信してみてね'),
                    );
                  } else {
                    List<Message> _newSnapshot =
                        snapshot.data!.docs.map((e) => Message(e)).toList();
                    return ListView.builder(
                        itemCount: _newSnapshot.length,
                        itemBuilder: (BuildContext context, int index) {
                          return messageList(
                              context: context,
                              messageList: _newSnapshot,
                              index: index);
                        });
                  }
                }),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: kNuanceColour),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextField(
                      controller: _messageController,
                      onChanged: (text) {
                        _messageText = text;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      ///ボタンを押したらfirebase（自分と相手）のmessageにデータを保存する
                      onPressed: () {
                        _firestoreModel.postMessage(
                            friendId: friendId,
                            friendName: friendName,
                            message: _messageText);

                        _firestoreModel.setFriendList(
                            friendId: friendId,
                            friendName: friendName,
                            message: _messageText);
                      },
                      icon: Icon(
                        Icons.send,
                        color: kAccentColour,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
