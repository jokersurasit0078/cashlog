import 'package:flutter/material.dart';

Widget loadingSnapshot (Widget widgetcenter){
  return Center(
    child: Column(
      children: [SizedBox(height: 30), widgetcenter, SizedBox(height: 30)],
    ),
  );
}