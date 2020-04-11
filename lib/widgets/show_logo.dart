import 'package:flutter/material.dart';

Widget showLogo() {
  return new Hero(
    tag: 'hero',
    child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: CircleAvatar(
          backgroundImage: new AssetImage('assets/img/default.png'),
          radius: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
    ),
  );
}
