import 'package:chat_re/constants/constants.dart';
import 'package:chat_re/objects/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget messageList(
    {required BuildContext context,
    required List<Message> messageList,
    required int index}) {
  return messageList[index].userId != '' ? Padding(
    padding: const EdgeInsets.only(left: 88.0, right: 16.0, top: 8.0, bottom: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kTextColour,
        border: Border.all(color: kTextColour),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          messageList[index].message!,
          style: TextStyle(
            color: kBaseColour,
          ),
        ),
      ),
    ),
  ) : Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 88.0, top: 8.0, bottom: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: kBaseColour,
        border: Border.all(color: kTextColour),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          messageList[index].message!,
          style: TextStyle(
            color: kTextColour,
          ),
        ),
      ),
    ),
  );
}


