import 'package:cashlog/routes.dart';
import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';

PreferredSizeWidget appbarPop (BuildContext context, String title) {
  var themeColor = ColorSet();
  var routes = Routes();
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: (TextStyle(fontFamily: 'Prompt'))),
          ],
        )
      ],
    ),
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_new),
      onPressed: (){
        Navigator.popUntil(context, ModalRoute.withName(routes.dashboard['name']));
      }
    ),
    backgroundColor: themeColor.greenDark,
  );
}