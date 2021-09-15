import 'package:cashlog/constant.dart';
import 'package:flutter/material.dart';

Widget buttonTextActionLoading(
  String text,
  Color color1,
  Color color2,
  Function onClick,
  bool isLoading,
  double radius
){
  var theme = Constant();
  return Container(
    constraints: BoxConstraints(minWidth: 200.0, minHeight: 50.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color1, color2]),
        borderRadius: BorderRadius.circular(radius)
      ),
      child: ElevatedButton(
        onPressed: !isLoading ? () =>  onClick() : null,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: !isLoading ? Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: theme.textSubTitle,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Prompt',
          ),
        ) : RefreshProgressIndicator()
      ),
    )
  );
}