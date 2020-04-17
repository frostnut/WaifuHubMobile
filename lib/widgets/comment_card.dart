import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../models/user.dart';
import './user_details_with_icon.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final User user;

  const CommentCard({Key key, this.comment, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          userDetailsWithIcon(user),
          Text(
            comment.text,
            textAlign: TextAlign.left,
          ),
          Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
