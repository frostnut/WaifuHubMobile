import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../global/assets.dart';
import '../models/comment.dart';
import '../models/user.dart';
import '../util/hub_display_screen_arguments.dart';
import '../widgets/comment_card.dart';

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
    HubDisplayScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("test"),
            onPressed: () => {},
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
                FutureBuilder(
                  future: _fetchComments(args.id),
                  builder: (BuildContext context, AsyncSnapshot commentSnap) {
                    return Container(
                      height: 250,
                      child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) => new FutureBuilder(
                          future: _fetchUserByComment(commentSnap.data[index]),
                          builder:
                              (BuildContext context, AsyncSnapshot userSnap) {
                            if (userSnap.hasData) {
                              return CommentCard(
                                user: userSnap.data,
                                comment: commentSnap.data[index],
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    );
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
  Future<List<Comment>> _fetchComments(String hubId) async {
    var commentList = [];
    DocumentSnapshot hubSnap =
        await Firestore.instance.collection("hubs").document(hubId).get();
    var comments = hubSnap.data["comments"];
    for (String comment in comments) {
      DocumentSnapshot commentSnap = await Firestore.instance
          .collection("comments")
          .document(comment)
          .get();

      Comment addComment = new Comment(
        hubId: commentSnap.data["hubId"],
        userId: commentSnap.data["userId"],
        likes: commentSnap.data["likes"],
        text: commentSnap.data["text"],
        id: commentSnap.data["id"],
        stamp: commentSnap.data["stamp"],
      );
      commentList.add(addComment);
    }
    return (commentList != null) ? commentList : null;
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

  Future<User> _fetchUserByComment(Comment comment) async {
    DocumentSnapshot ds = await Firestore.instance
        .collection('comments')
        .document(comment.id)
        .get();
    String userId = ds.data["userId"];
    DocumentSnapshot userDs =
        await Firestore.instance.collection('users').document(userId).get();
    return new User(
        profPicUrl: userDs.data["profPicUrl"],
        apiKey: userDs.data["apiKey"],
        email: userDs.data["email"],
        hubIDs: userDs.data["hubIDs"],
        username: userDs.data["username"],
        userID: userDs.data["userID"],
        status: userDs.data["status"]);
  }
}
