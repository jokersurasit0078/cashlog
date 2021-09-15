import 'package:cashlog/Model/totalTransactionDayModel.dart';
import 'package:cashlog/Widgets/Dropdown.dart';
import 'package:cashlog/constant.dart';
import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';


// ignore: must_be_immutable
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late double screenWidth, screenHeight;
  var themeColor = new ColorSet();
  var constant = new Constant();
  late var totalTransactionDayModel = new TotalTransactionDayModel.addNewDate(constant.thisDate);

  String value = 'Apple';
  List<String> items = ['Apple', 'Samsung', 'Xiao Mi', 'Vivo', 'Nokia'];

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text('Test',
        style: (TextStyle(fontFamily: 'Prompt'))),
        backgroundColor: themeColor.greenDark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [themeColor.greenLight, Colors.white]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customDropdown(value, items, setValueDropdown)
            ]
          ),
        ),
      ),
    );
  }
  setValueDropdown(String? newValue) {
    this.setState(() {
      value = newValue!;
    });
  }
}
