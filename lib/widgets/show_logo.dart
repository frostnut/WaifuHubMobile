import 'package:flutter/material.dart';

/// used to gen circular logos on 
/// form pages
Widget showLogo(String pic) {
  return new Hero(
    tag: 'hero',
    child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: CircleAvatar(
          backgroundImage: new AssetImage(pic),
          radius: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
    ),
  );
}
