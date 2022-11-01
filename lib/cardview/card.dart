// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';

import '../assets/constants.dart' as Constants;

class CardView extends StatelessWidget {
  const CardView({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: Constants.TASK_BACK_COLOR,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(text,
              style: const TextStyle(
                color: Constants.TASK_TEXT_COLOR,
                fontSize: Constants.TASK_TEXT_FONT,
              )),
        ),
      ),
    ));
  }
}
