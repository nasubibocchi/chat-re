import 'dart:convert';

import 'package:chat_re/main.dart';
import 'package:chat_re/objects/userData.dart';
import 'package:chat_re/simplemodel/misc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nonce/nonce.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LogInModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  UserData? userData;
  final _misc = Misc();

  ///google
  Future<void> googleSignIn(
      {required Function startLoading,
      required Function endLoading,
      required BuildContext context,
      required String dialogText}) async {
    try {
      startLoading();
      final googleUser = await _googleSignIn.signIn(); //サインインメソッド
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var uid = '';
      await auth.signInWithCredential(credential).then((value) async {
        uid = value.user!.uid;

        ///ユーザー登録あり
        if (value.additionalUserInfo!.isNewUser == false) {
          await firestore.collection('users').doc(uid).update(<String, dynamic>{
            'signInAt': FieldValue.serverTimestamp(),
          });

          ///ダイアログを表示
          await _misc.showMyDialog(context: context, text: dialogText);

          ///新規ユーザー
        } else {
          try {
            await firestore.collection('users').doc(uid).set(<String, dynamic>{
              'userName': value.user!.displayName ?? '',
              'userId': value.user!.uid,
              'iconUrl': value.user!.photoURL ?? '',
              'signInAt': FieldValue.serverTimestamp(),
            });
            await firestore
                .collection('basicInfo')
                .doc('H0SVn9Tv6o39S3MKi7nP')
                .update({'numberOfResistrants': FieldValue.increment(1)});

            ///ダイアログを表示
            await _misc.showMyDialog(context: context, text: dialogText);
          } catch (e) {
            print('login failed $e');
          }
        }
      });

      final snapshot = await firestore.collection('users').doc(uid).get();
      userData = UserData(snapshot);
      print('---------------------get user\'s info');

      endLoading();
    } catch (e) {
      print('login failed $e');
      endLoading();
    }
  }

  ///apple
  Future<void> appleSignIn(
      {required Function startLoading,
      required Function endLoading,
      required BuildContext context,
      required String dialogText}) async {
    try {
      startLoading();

      final rawNonce = Nonce.generate();
      final state = Nonce.generate();
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [],
        nonce: sha256.convert(utf8.encode(rawNonce)).toString(),
        state: state,
      );

      if (appleCredential == null) return;
      if (state != appleCredential.state) {
        throw AssertionError('state not matched!');
      }
      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
        rawNonce: rawNonce,
      );

      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;
      final uid = user!.uid;

      ///ユーザー登録あり
      if (userCredential.additionalUserInfo!.isNewUser == false) {
        await firestore.collection('users').doc(uid).update({
          'signInAt': FieldValue.serverTimestamp(),
        });

        ///ダイアログを表示
        await _misc.showMyDialog(context: context, text: dialogText);

        ///新規ユーザー
      } else {
        await firestore.collection('users').doc(uid).set(<String, dynamic>{
          'userName': appleCredential.givenName ?? '',
          'userId': uid,
          'iconUrl': '',
          'signInAt': FieldValue.serverTimestamp(),
        });
        await firestore
            .collection('basicInfo')
            .doc('H0SVn9Tv6o39S3MKi7nP')
            .update({'numberOfResistrants': FieldValue.increment(1)});

        ///ダイアログを表示
        await _misc.showMyDialog(context: context, text: dialogText);

        endLoading();
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        print(e);
        endLoading();
        return;
      }
      endLoading();
      rethrow;
    }
  }
}
