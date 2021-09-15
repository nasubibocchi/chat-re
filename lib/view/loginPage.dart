import 'dart:io';

import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/main.dart';
import 'package:chat_re/simplemodel/loginModel.dart';
import 'package:chat_re/simplemodel/misc.dart';
import 'package:chat_re/statemodel/loginStateModel.dart';
import 'package:chat_re/view/weidgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chatRoomListPage.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({required this.index});

  int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///google, appleのサインインモデル
    final _loginModel = LogInModel();

    ///その他のモデル
    final _misc = Misc();

    return DefaultTabController(
      initialIndex: index,
      length: 2,
      child: Scaffold(
        appBar: myAppBar(title: 'ログインまたは新規登録'),
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
                        Platform.isIOS == true
                            ? Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),

                                      ///google
                                      child: SignInWithGoogle(onPressed: () {
                                        ///ログイン
                                        _loginModel.googleSignIn(
                                            context: context,
                                            startLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .startLoading(),
                                            endLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .endLoading(),
                                            dialogText: 'ログインしました。');

                                        ///ページ遷移
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatRoomListPage()));
                                      }),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),

                                      ///apple
                                      child: SignInWithApple(onPressed: () {
                                        _loginModel.appleSignIn(
                                            context: context,
                                            startLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .startLoading(),
                                            endLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .endLoading(),
                                            dialogText: 'ログインしました。');

                                        ///ページ遷移
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatRoomListPage()));
                                      }),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithGoogle(onPressed: () {
                                        ///ログイン
                                        _loginModel.googleSignIn(
                                            context: context,
                                            startLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .startLoading(),
                                            endLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .endLoading(),
                                            dialogText: 'ログインしました。');

                                        ///ページ遷移
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatRoomListPage()));
                                      }),
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
                                      child: SignInWithGoogle(onPressed: () {
                                        ///ログイン
                                        _loginModel.googleSignIn(
                                            context: context,
                                            startLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .startLoading(),
                                            endLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .endLoading(),
                                            dialogText: '登録しました。');

                                        ///ログインを促す
                                        _misc.showMyDialog(
                                            context: context,
                                            text: 'ログインもお願いします');
                                      }),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithApple(onPressed: () {
                                        ///ログイン
                                        _loginModel.appleSignIn(
                                            context: context,
                                            startLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .startLoading(),
                                            endLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .endLoading(),
                                            dialogText: '登録しました。');

                                        ///ログインを促す
                                        _misc.showMyDialog(
                                                context: context,
                                                text: 'ログインもお願いします');
                                      }),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SignInWithGoogle(onPressed: () {
                                        ///ログイン
                                        _loginModel.googleSignIn(
                                            context: context,
                                            startLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .startLoading(),
                                            endLoading: () => ref
                                                .read(
                                                    loginStateProvider.notifier)
                                                .endLoading(),
                                            dialogText: '登録しました。');

                                        ///ログインを促す
                                        _misc.showMyDialog(
                                                context: context,
                                                text: 'ログインもお願いします');
                                      }),
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
