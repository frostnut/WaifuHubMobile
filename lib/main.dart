import 'package:WaifuHub/account.dart';
import 'package:WaifuHub/explore.dart';
import 'package:WaifuHub/hubs.dart';
import 'package:flutter/material.dart';
import './widgets/bottomNavBar.dart';

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
        '/explore': (context) => Explore(),
        '/account': (context) => Account(),
      },
    );
  }
}
