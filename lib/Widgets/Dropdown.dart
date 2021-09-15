import 'package:flutter/material.dart';

Widget customDropdown (String value, List<String> items, Function setValueDropdown) {
  return Container(
    width: 300,
    child: ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton(
        isExpanded: true,
        value: value,
        items: items.map((String items) {
          return DropdownMenuItem<String>(
            value: items,
            child: Text(items.toString())
          );
        }).toList(),
        onChanged: (String? newValue){
          setValueDropdown(newValue);
        },
      )
    ),
  );
}