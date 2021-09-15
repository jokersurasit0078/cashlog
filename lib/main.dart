import 'package:cashlog/preferences.dart';
import 'package:cashlog/routes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

// ignore: must_be_immutable
class App extends StatelessWidget {
  var routes = new Routes();
  var prefs = new Preferences();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash-Log',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.green,
        ),
      ),
      initialRoute: routes.login['name'],
      routes: {
        routes.home['name'] : (context) => routes.home['page'],
        routes.login['name'] : (context) => routes.login['page'],
        routes.dashboard['name'] : (context) => routes.dashboard['page'],
        routes.search['name'] : (context) => routes.search['page'],
        routes.addTransactions['name'] : (context) => routes.addTransactions['page'],
        routes.test['name'] : (context) => routes.test['page'],
      },
    );
  }
}

