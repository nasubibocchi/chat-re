import 'package:chat_re/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final buttonColourProvider =
    StateNotifierProvider<ButtonColourState, ButtonColour>(
        (refs) => ButtonColourState());

class ButtonColour {
  ButtonColour({required buttonColour, required textColour});

  Color? buttonColour;
  Color? textColour;
}

class ButtonColourState extends StateNotifier<ButtonColour> {
  ButtonColourState()
      : super(ButtonColour(buttonColour: kBaseColour, textColour: kTextColour));

  Future<void> changeColour() async {
    state = ButtonColour(buttonColour: kAccentColour, textColour: kBaseColour);
  }
}
