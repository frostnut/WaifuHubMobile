import 'package:WaifuHub/account.dart';
import 'package:WaifuHub/explore.dart';
import 'package:WaifuHub/sign_in.dart';
import './sign_up.dart';
import './forgot_password.dart';
import 'package:WaifuHub/hubs.dart';
import 'package:WaifuHub/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaifuHub',
      home: BottomNavigationBarController(),
      initialRoute: '/',
      routes: {
        '/hubs': (context) => Hubs(),
        '/signin': (context) => SignInScreen(),
        '/explore': (context) => Explore(),
        '/account': (context) => Account(),
        '/signup' : (context) => SignUpScreen(),
        '/forgot-password' : (context) => ForgotPasswordScreen(),
      },
    );
  }
}
