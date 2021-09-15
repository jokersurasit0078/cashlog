import 'package:cashlog/Page/AddTransactions.dart';
import 'package:cashlog/Page/Dashboard.dart';
import 'package:cashlog/Page/Login.dart';
import 'package:cashlog/Page/Search.dart';
import 'package:cashlog/Page/Test.dart';

class Routes{
  // List home = ['/', Login()];
  // List login = ['/login', Login()];
  // List search = ['/search', Search()];
  // List addTransactions = ['/add_transactions', AddTransactions()];
  // List dashboard = ['/dashboard', Dashboard()];
  Map home = {
    'name': '/',
    'page': Login()
  };
  Map login = {
    'name': '/login',
    'page': Login()
  };
  Map search = {
    'name': '/search',
    'page': Search()
  };
  Map addTransactions = {
    'name': '/add_transactions',
    'page': AddTransactions()
  };
  Map dashboard = {
    'name': '/dashboard',
    'page': Dashboard()
  };
  Map test = {
    'name': '/test',
    'page': Test()
  };
}