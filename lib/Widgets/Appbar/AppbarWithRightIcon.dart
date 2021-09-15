import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';

PreferredSizeWidget appbarWithRightIcon (BuildContext context, String title, Function onClickRightIcon, Icon iconRight) {
  var themeColor = ColorSet();
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: (TextStyle(fontFamily: 'Prompt'))),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: iconRight,
              color: Colors.white,
              onPressed: () async {
                onClickRightIcon();
              },
            )
          ],
        )
      ],
    ),
    backgroundColor: themeColor.greenDark,
  );
}