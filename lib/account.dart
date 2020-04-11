import 'package:flutter/material.dart';
import './login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatelessWidget {
  const Account({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Account Screen"),
        ),
        body: RaisedButton(
          child: Text(
            "Log out",
          ),
          onPressed: () => _signOut(context),
        ));
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
