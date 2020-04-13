import 'package:WaifuHub/global/assets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Account page displays user specific info
/// Also contains the edit profile Icon button
/// and the log out button.
class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  FirebaseUser _user;
  String _error;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightPinkColor,
          centerTitle: true,
          title: Text("Your Account"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  _genProfPic(context),
                  Container(
                    width: 100,
                  ),
                  IconButton(
                    color: darkPinkColor,
                    icon: new Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              _fetchUsername(context),
              RaisedButton(
                color: lightPinkColor,
                onPressed: () => _signOut(context),
                child: Text(
                  "Log out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// handles logging out logic, uses FirebaseAuth
  /// sign out and pushes back to login
  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  /// retrieves user's username
  /// https://pub.dev/packages/firebase_auth
  Widget _fetchUsername(BuildContext context) {
    try {
      return new StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(_user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading...");
            }
            var userDocument = snapshot.data;
            return new Text(
              userDocument.data['username'].toString(),
              style: headingLarge,
            );
          });
    } on NoSuchMethodError {
      return new CircularProgressIndicator();
    }
  }

  /// fetches profile pic URL and generates
  /// the circular avatar using a network
  /// image
  Widget _genProfPic(BuildContext context) {
    try {
      return new StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(_user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var userDocument = snapshot.data;
            var picUrl = userDocument.data['profPicUrl'].toString();
            return new CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(picUrl),
            );
          });
    } on NoSuchMethodError {
      return new CircularProgressIndicator();
    }
  }
}
