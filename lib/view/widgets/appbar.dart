import 'package:chat_re/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar ({required String title}) {
  return AppBar(
    title: Text(title, style: TextStyle(color: kTextColour),),
    backgroundColor: kBaseColour,
    //TODO: マイページへ移動する
    actions: [],
  );
}