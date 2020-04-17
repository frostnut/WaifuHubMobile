import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../global/assets.dart';
import '../models/comment.dart';
import '../util/hub_display_screen_arguments.dart';

class CommentPage extends StatefulWidget {
  static const routeName = '/comment';
  final HubDisplayScreenArguments args;

  CommentPage(this.args);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _controller = TextEditingController();
  final GlobalKey<FormState> _commentFormKey = GlobalKey<FormState>();
  FirebaseUser _user;
  String _error;
  List<Comment> _comments = [];

  /// sets current user
  void setUser(FirebaseUser user) {
    setState(() {
      this._user = user;
      this._error = null;
    });
  }

  /// sets error if error fetching user
  void setError(e) {
    setState(() {
      this._user = null;
      this._error = e.toString();
    });
  }

  /// calls the fetch comments and sets them in the
  /// list of comments for this hub
  void setComments() {
    _fetchComments(widget.args.id);
    setState(() {
      _comments = _comments;
    });
  }

  void initState() {
    _controller.addListener(() {
      final text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    setComments();
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }

  @override
  Widget build(BuildContext context) {
    final HubDisplayScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("test"),
            onPressed: () => _printComments(),
          ),
          Form(
            key: _commentFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                RaisedButton(
                  child: Text("add"),
                  color: lightPinkColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_commentFormKey.currentState.validate()) {
                      print("bump");
                      _addComment(_controller.text, args.id, _user.uid);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// fetches all comments for this hub as a stream
  _fetchComments(String hubId) {
    return Firestore.instance
        .collection("hubs")
        .document(hubId)
        .get()
        .then((snapshot) {
      try {
        var comments = snapshot.data["comments"];
        for (String comment in comments) {
          Firestore.instance
              .collection("comments")
              .document(comment)
              .get()
              .then((snapshot) {
            Comment addComment = new Comment(
              hubId: snapshot.data["hubId"],
              userId: snapshot.data["userId"],
              likes: snapshot.data["likes"],
              text: snapshot.data["text"],
              id: snapshot.data["id"],
              stamp: snapshot.data["stamp"],
            );
            _comments.add(addComment);
          }).asStream();
        }
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  void _printComments() {
    print(_comments);
  }

  /// method used to add comment to hub - needs to create the comment
  /// and also update the hub to store the reference to the comment id
  _addComment(String text, String hubId, String userId) {
    Comment comment = new Comment(
      hubId: hubId,
      text: text,
    );
    comment.createComment(Firestore.instance, hubId, userId, text);
    List<dynamic> newComments = [];
    newComments.add(comment.id);
    Firestore.instance
        .collection("hubs")
        .document(hubId)
        .updateData({"comments": FieldValue.arrayUnion(newComments)});
  }
}
