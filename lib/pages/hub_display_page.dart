import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../global/assets.dart';
import '../pages/hub_comments_page.dart';
import '../util/hub_display_screen_arguments.dart';

class HubDisplay extends StatefulWidget {
  static const routeName = '/hubdisplay';
  const HubDisplay({Key key}) : super(key: key);

  @override
  _HubDisplayState createState() => _HubDisplayState();
}

class _HubDisplayState extends State<HubDisplay> {
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
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final HubDisplayScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: args.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image(
                        image: NetworkImage(args.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: lightPinkColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          iconSize: 30.0,
                          color: lightPinkColor,
                          onPressed: () => _likePage(args.id),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.comment),
                          iconSize: 25.0,
                          color: lightPinkColor,
                          onPressed: () => Navigator.pushNamed(
                            context,
                            CommentPage.routeName,
                            arguments: HubDisplayScreenArguments(
                              args.id,
                              args.commentIDs,
                              args.hubname,
                              args.description,
                              args.imageUrl,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      args.hubname,
                      style: headingLarge,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        args.description,
                        style: textStandard,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        args.description,
                        style: textStandard,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// handles logic of liking a page, essentially
  /// just fetches the current number of likes,
  /// increments them and then puts new number of
  /// likes into the db
  /// also makes user follow the page
  void _likePage(String hubId) async {
    DocumentSnapshot snap =
        await Firestore.instance.collection("hubs").document(hubId).get();
    int pageLikes = snap.data["likes"];
    pageLikes += 1;
    Firestore.instance.collection("hubs").document(hubId).updateData({
      'likes': pageLikes,
    });
    _followPage(hubId);
  }

  /// adds this hub id to user's hub list
  void _followPage(String hubId) async {
    List<dynamic> newHub = [];
    newHub.add(hubId);
    Firestore.instance
        .collection("users")
        .document(_user.uid)
        .updateData({"hubIDs": FieldValue.arrayUnion(newHub)});
  }

  /// handles logic to unlike a page, decrements the 
  /// likes and unfollows user from the page
  void _unlikePage(String hubId) async {
    DocumentSnapshot snap =
        await Firestore.instance.collection("hubs").document(hubId).get();
    int pageLikes = snap.data["likes"];
    pageLikes -= 1;
    Firestore.instance.collection("hubs").document(hubId).updateData({
      'likes': pageLikes,
    });
    _unFollowPage(hubId);
  }

  /// removes this hub id to user's hub list
  void _unFollowPage(String hubId) async {
    List<dynamic> removeHub = [];
    removeHub.add(hubId);
    Firestore.instance
        .collection("users")
        .document(_user.uid)
        .updateData({"hubIDs": FieldValue.arrayRemove(removeHub)});
  }
}
