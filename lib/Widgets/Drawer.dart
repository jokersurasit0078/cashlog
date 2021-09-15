import 'package:cashlog/preferences.dart';
import 'package:cashlog/routes.dart';
import 'package:flutter/material.dart';
import 'ColorSet.dart';

Widget drawer(BuildContext context) {
  var themeColor = ColorSet();
  var routes = Routes();
  var prefs = Preferences();
  return Drawer(
    child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("เมนู", style: TextStyle(fontSize: 18, fontFamily: 'Prompt')),
          accountEmail: Text("Cash-Log", style: TextStyle(fontSize: 18, fontFamily: 'Prompt')),
          decoration: BoxDecoration(
            // color: Color(0xff0000b3),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [themeColor.greenLight, themeColor.greenDark]
            )
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.search),
                title: Text("ค้นหารายการ", style: TextStyle(fontFamily: 'Prompt')),
                onTap: () {
                  Navigator.pushNamed(context, routes.search['name']);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_box),
                title: Text("เพิ่มรายการ", style: TextStyle(fontFamily: 'Prompt')),
                onTap: () {
                  Navigator.pushNamed(context, routes.addTransactions['name']);
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.add_box),
              //   title: Text("Test", style: TextStyle(fontFamily: 'Prompt')),
              //   onTap: () {
              //     Navigator.pushNamed(context, routes.test['name']);
              //   },
              // ),
            ],
          ),
        ),
        Container(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              child: Column(
                children: <Widget>[
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("ออกจากระบบ", style: TextStyle(fontFamily: 'Prompt')),
                    onTap: () {
                      prefs.logout();
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName(routes.login['name']),
                      );
                    },
                  ),
                  Divider(),
                ],
              )
            )
          )
        )
      ],
    )
  );
}

