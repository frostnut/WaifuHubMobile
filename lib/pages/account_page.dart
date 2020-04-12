import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("Logout"),
        onPressed: () => _signOut(context),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
