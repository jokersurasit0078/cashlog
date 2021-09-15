import 'dart:ui';
import 'package:cashlog/Widgets/Button/ButtonTextActionLoading.dart';
import 'package:cashlog/Widgets/ShowAlertDialog.dart';
import 'package:cashlog/preferences.dart';
import 'package:cashlog/routes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';
import 'package:cashlog/Widgets/TextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }
  var themeColor = ColorSet();
  var routes = Routes();
  var prefs = Preferences();

  late bool isLoading = false;
  late double screenWidth, screenHeight;

  var username = new TextEditingController();
  var password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    // screenHeight = size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    screenHeight = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [themeColor.greenLight, Colors.white]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 6),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 120.0, maxHeight: 120.0),
                      child: Image.asset('images/online-payment.png'),
                    ),
                    SizedBox(height: 30),
                    textFieldLogin(username, Icon(Icons.supervised_user_circle_rounded), 'ชื่อผู้ใช้งาน', false),
                    SizedBox(height: 15),
                    textFieldLogin(password, Icon(Icons.password_sharp), 'รหัสผ่าน', true),
                    SizedBox(height: 30),
                    buttonTextActionLoading("เข้าสู่ระบบ", themeColor.greenLight, themeColor.greenDark, () => onClickLogin(), isLoading, 15)
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
  onClickLogin() async {
    this.setState(() {
      this.isLoading = true;    
    });
    await handleClickLogin().then((value) async => {
      if(value[0] == username.text && value[1] == password.text){
        this.setState(() {
          this.isLoading = false;
        }),
        await prefs.login(),
        if(await prefs.isLogin()){
          Navigator.pushNamed(context, routes.dashboard['name'])
        } 
        else{
          dialogCustom(
            context,
            'ระบบขัดข้อง',
            'ไม่สามารถเข้าสูระบบได้',
            () => onClickCloseAlert(),
            themeColor.redLight
          ),
        }
      }
      else{
        dialogCustom(
          context,
          'ไม่สามารถเข้าสูระบบได้ ! ! !',
          'ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง',
          () => onClickCloseAlert(),
          themeColor.redLight
        ),
      }
    });
  }
  onClickCloseAlert(){
    this.setState(() {
      this.isLoading = false;
      this.password.text = '';
    });
  }
  Future<List<String>> handleClickLogin() async {
    List<String> account = [];
    await FirebaseFirestore.instance
      .collection('User')
      .get()
      .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          account.add(doc['username']);
          account.add(doc['password']);
        });
      }
    );
    return account;
  }
}