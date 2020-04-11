import 'pages/splash_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaifuHub',
      home: SplashPage(),
      initialRoute: '/',
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
