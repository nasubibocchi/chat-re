import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/simplemodel/misc.dart';
import 'package:chat_re/view/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'route_page/user_list_page.dart';

class SerchUserPage extends HookConsumerWidget {
  ///変数
  String userName = '';
  ///テキストコントローラ
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///コントローラ（ボタンの色を変える）
    // final _buttonColourController = ref.watch(buttonColourProvider);//未使用

    ///モデル
    final _misc = Misc();

    return Scaffold(
      appBar: myAppBar(title: 'ユーザーを探す'),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'ユーザー名を入力',
                  hintText: 'ぴとこさん',
                  labelStyle: TextStyle(color: kTextColour),
                  hintStyle: TextStyle(color: kNuanceColour),
                ),
                keyboardType: TextInputType.text,
                controller: _userNameController,
                onChanged: (text) {
                  // ref.read(buttonColourProvider.notifier).changeColour();
                  userName = _userNameController.value.text;
                  // userName = text;
                  print(userName);
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              MaterialButton(
                onPressed: () {
                  print(userName);
                  userName != ''
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserListPage(userName: userName)))
                      : _misc.showMyDialog(context: context, text: 'ユーザー名を入力してね');
                },
                child: Text(
                  '検索する',
                  style: TextStyle(color: kBaseColour),
                ),
                color: kAccentColour,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              SizedBox(
                height: 30.0,
                width: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
