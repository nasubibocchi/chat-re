import 'package:chat_re/constants/constants.dart';
import 'package:flutter/material.dart';

class Misc {
  ///確認ダイアログ
  Future<void> showMyDialog({required context, required text}) async {
    final dialogResult = showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('かくにん'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text, style: TextStyle(color: kTextColour)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: kTextColour)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return await dialogResult;
  }
}
