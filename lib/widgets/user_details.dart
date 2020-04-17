import 'package:flutter/material.dart';
import '../models/user.dart';

Widget userDetails(User user) {
  return Container(
    child: Row(children: <Widget>[
      CircleAvatar(
        backgroundImage: NetworkImage(user.profPicUrl),
        radius: 30,
      ),
      Text(user.username),
    ]),
  );
}
