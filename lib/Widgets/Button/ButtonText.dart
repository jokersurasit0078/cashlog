import 'package:flutter/material.dart';

Widget buttonSetText(String textButton, Color background, Function onClick){
  return ElevatedButton(
    onPressed: (){
      onClick();
    },
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: background,
    ),
    child: Container(
      constraints: BoxConstraints(minHeight: 40.0),
      alignment: Alignment.center,
      child: Text(
        '$textButton',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontFamily: 'Prompt',
        ),
      ),
    ),
  );
}