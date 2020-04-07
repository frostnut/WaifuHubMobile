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
    );
  }
}
