import 'package:cashlog/Widgets/ColorSet.dart';
import 'package:cashlog/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textFieldSearch(TextEditingController controller, String label, double width, double height) {
  var theme = Constant();
  return Container(
    constraints: BoxConstraints(maxWidth: width, maxHeight: height),
    child: TextField(
      controller: controller,
      enabled: false,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: theme.textDetail),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}

Widget textFieldLogin(TextEditingController controller, Icon icon, String label, bool hideText) {
  var themeColor = ColorSet();
  var theme = Constant();
  return Container(
    constraints: BoxConstraints(maxWidth: 300.0, maxHeight: 50.0),
    child: TextField(
      cursorColor: Colors.black,
      controller: controller,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: theme.textDetail),
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeColor.greenDark, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}

Widget textFieldDate(TextEditingController controller, Icon icon, double width){
  // var themeColor = ColorSet();
  var theme = Constant();
  return Container(
    constraints: BoxConstraints(maxWidth: width, minHeight: 30.0),
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: TextField(
      enabled: false,
      controller: controller,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: theme.textDetail),
      decoration: InputDecoration(
        prefixIcon: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
  );
}

Widget textFieldInput(TextEditingController controller, Icon icon, double width, TextInputFormatter format){
  // var themeColor = ColorSet();
  var theme = Constant();
  return Container(
    constraints: BoxConstraints(maxWidth: width, minHeight: 30.0),
    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
    child: TextField(
      controller: controller,
      // keyboardType: typeText,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: theme.textDetail),
      inputFormatters: <TextInputFormatter>[
        format
      ],
      decoration: InputDecoration(
        prefixIcon: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
  );
}