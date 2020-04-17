import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/models/comment.dart';
import 'package:WaifuHub/util/hub_display_screen_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  static const routeName = '/comment';
  CommentPage({Key key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _controller = TextEditingController();
  final GlobalKey<FormState> _commentFormKey = GlobalKey<FormState>();
  FirebaseUser _user;
  String _error;

  /// sets current user
  void setUser(FirebaseUser user) {
    setState(() {
      this._user = user;
      this._error = null;
    });
  }

  /// sets error if error fethcing user
  void setError(e) {
    setState(() {
      this._user = null;
      this._error = e.toString();
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
            onPressed: () => _fetchComments(args.id),
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
                      _addComments(_controller.text, args.id, _user.uid);
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

  _fetchComments(String hubId) {
    return Firestore.instance
        .collection("hubs")
        .document(hubId)
        .get()
        .then((snapshot) {
      try {
        var comments = snapshot.data["comments"];
        print(comments);
        print("ok");
      } catch (e) {
        print(e);
        return null;
      }
    }).asStream();
  }

  _addComments(String text, String hubId, String userId) {
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
