import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/objects/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget messageList(
    {required BuildContext context,
    required List<Message> messageList,
    required int index}) {
  return Container(
    decoration: BoxDecoration(
      color: messageList[index].userId != '' ? kTextColour : kBaseColour,
      border: Border.all(color: kTextColour),
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Text(
      messageList[index].message!,
      style: TextStyle(
        color: messageList[index].userId != '' ? kBaseColour : kTextColour,
      ),
    ),
  );
}
