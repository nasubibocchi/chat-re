import 'dart:io';

import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/view/weidgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class LoginPage extends StatelessWidget {
  LoginPage({required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: index,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kBaseColour,
            title: Text('ログイン＆新規登録', style: TextStyle(color: kTextColour))),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 80.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    child: TabBar(
                      labelColor: kTextColour,
                      indicatorColor: kAccentColour,
                      tabs: [
                        Tab(text: 'ログイン'),
                        Tab(text: '新規登録'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        //TODO: サインインメソッドを呼び出す
                        Platform.isIOS == true
                            ? Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithGoogle(onPressed: () {}),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithApple(onPressed: () {}),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithGoogle(onPressed: () {}),
                                    ),
                                  ),
                                ],
                              ),
                        Platform.isIOS == true
                            ? Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithGoogle(onPressed: () {}),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithApple(onPressed: () {}),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithGoogle(onPressed: () {}),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
