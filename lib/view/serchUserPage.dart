import 'package:chat_re/simplemodel/misc.dart';
import 'package:chat_re/view/weidgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pushPage/userListPage.dart';

class SerchUserPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///コントローラ（ボタンの色を変える）

    final _misc = Misc();

    ///テキストコントローラ
    TextEditingController _userNameController = TextEditingController();

    String _userName = '';

    return Scaffold(
      appBar: myAppBar(title: 'ユーザーを探す'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: ボタンの色を変える
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: TextField(
              controller: _userNameController,
              onChanged: (text) {
                _userName = text;
              },
            ),
          ),
          MaterialButton(
            onPressed: () {
              _userName != ''
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserListPage(userName: _userName)))
                  : _misc.showMyDialog(context: context, text: 'ユーザー名を入力してね');
            },
            child: Text('検索する'),
          ),
          SizedBox(
            height: 30.0,
            width: 30.0,
          ),
        ],
      ),
    );
  }
}
