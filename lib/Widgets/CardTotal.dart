import 'package:cashlog/constant.dart';
import 'package:flutter/material.dart';

Widget cardTotal(
  double screenWidth,
  String title,
  Color mainColor,
  Color subColor,
  String data
){
  var theme = Constant();
  return Container(
    height: 120,
    width: screenWidth<1300 ? screenWidth*0.85 : screenWidth/3.5,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [subColor, mainColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 20,
          spreadRadius: 5,
        ) 
      ]
    ),
    child: Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Container(
                height: 35,
                width: 35,
                child: Icon(
                  Icons.insert_chart_rounded,
                  color: Colors.black,
                  size: 25,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black, //                   <--- border color
                    width: 2,
                  ),
                ),
              ),
              SizedBox(width: 13),
              Container(
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontSize: theme.textSubTitle,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 40),
              Container(
                height: 25,
                width: 25,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black, //                   <--- border color
                    width: 2,
                  ),
                ),
              ),
              SizedBox(width: 13),
              Container(
                child: Text(
                  '$data',
                  style: TextStyle(
                    fontSize: theme.textSubTitle,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    ),
  );
}