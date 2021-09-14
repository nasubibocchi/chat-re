import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/view/weidgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SerchUserPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///コントローラ（ボタンの色を変える）

    ///テキストコントローラ
    TextEditingController _userNameController = TextEditingController();

    return Scaffold(
      appBar: myAppBar(title: 'ユーザーを探す'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: onchangedの定義（ボタンの色も変える）
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: TextField(
              controller: _userNameController,
              onChanged: (text) {},
            ),
          ),
          //TODO: 押したら検索&ボタン色はserchUserPageModelのstate
          MaterialButton(
            onPressed: () {},
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
