import 'package:WaifuHub/global/assets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  String error;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then(setUser).catchError(setError);
  }

  void setUser(FirebaseUser user) {
    setState(() {
      this.user = user;
      this.error = null;
    });
  }

  void setError(e) {
    setState(() {
      this.user = null;
      this.error = e.toString();
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  Widget _fetchUsername(BuildContext context) {
    try {
      return new StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(user.uid)
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

  Widget _genProfPic(BuildContext context) {
    try {
      return new StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(user.uid)
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
