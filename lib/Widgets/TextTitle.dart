import 'package:flutter/material.dart';

Widget textTitle(String text, double fontSize, FontWeight fontWeight) {
  return Text(
    '$text',
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.black,
      fontFamily: 'Prompt',
    ),
  );
}