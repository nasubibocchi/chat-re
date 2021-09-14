import 'package:chat_re/objects/message.dart';
import 'package:chat_re/view/weidgets/messageList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///firebase呼び出し用
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    ///テキストコントローラ
    TextEditingController _messageController = TextEditingController();

    ///変数
    String _messageText = '';

    return Scaffold(
      appBar: AppBar(
        //TODO: ダミー
        title: Text('ダミー'),
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
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                        snapshot.data!.docs.map((e) => Message(e)).toList();
                    return ListView.builder(
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
            child: Row(
              children: [
                TextField(
                  controller: _messageController,
                  onChanged: (text) {
                    _messageText = text;
                  },
                ),
                IconButton(
                  //TODO: ボタンを押したらfirebase（自分と相手）のmessageにデータを保存する
                  onPressed: (){},
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
