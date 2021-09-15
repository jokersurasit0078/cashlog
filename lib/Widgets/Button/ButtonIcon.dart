import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';

Widget buttonIcon (BuildContext context, Function onClick, Color? backgroundColor, IconData icon) {
  var themeColor = ColorSet();
  return ElevatedButton(
    onPressed: () async {
      onClick();
    },
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: backgroundColor == null ? themeColor.greenDark : backgroundColor,
    ),
    child: Container(
      constraints: BoxConstraints(maxWidth: 60, minHeight: 50.0),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}