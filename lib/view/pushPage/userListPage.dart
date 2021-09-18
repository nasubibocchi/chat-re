import 'package:chat_re/objects/userData.dart';
import 'package:chat_re/simplemodel/firestoreModel.dart';
import 'package:chat_re/view/weidgets/appbar.dart';
import 'package:chat_re/view/weidgets/userList.dart';
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
        builder: (BuildContext context, AsyncSnapshot<List<UserData>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('見つかりませんでした'),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
              return userList(
                  context: context,
                  userList: snapshot.data!,
                  index: index);
            });
          }
        },
      ),
    );
  }
}
