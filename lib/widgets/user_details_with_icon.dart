import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './user_details.dart';
import '../models/user.dart';

Widget userDetailsWithIcon(User user) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: userDetails(user),
      ),
      Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {},
          ),
        ),
      ),
    ],
  );
}
