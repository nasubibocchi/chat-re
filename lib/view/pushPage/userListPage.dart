import 'package:chat_re/objects/chatroom.dart';
import 'package:chat_re/simplemodel/firestoreModel.dart';
import 'package:chat_re/view/weidgets/appbar.dart';
import 'package:chat_re/view/weidgets/chatRoomList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  UserListPage({required this.userName});

  String userName;

  @override
  Widget build(BuildContext context) {
    ///firestoreModelインスタンス
    final _firestoreModel = FirestoreModel();

    return Scaffold(
      appBar: myAppBar(title: '検索結果一覧'),
      body: FutureBuilder(
        future: _firestoreModel.searchUserList(userName: userName),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('見つかりませんでした'),
            );
          } else {
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              return chatRoomList(
                  context: context,
                  chatRoomList: snapshot.data.map((e) => ChatRoom(e)).toList(),
                  index: index);
            });
          }
        },
      ),
    );
  }
}
