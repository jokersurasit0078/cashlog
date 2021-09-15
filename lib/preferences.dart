import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
  }
  isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool('isLogin');
    return value;
  }
}