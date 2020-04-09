import 'package:WaifuHub/global/assets.dart';
import 'package:flutter/material.dart';


/// SignIn is the sign in page
/// used to authenticate the user
/// uses a stateful widget and needs
/// to contain means to input data
class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Sign in",
                  style: headingLarge,
                ),
              ],
            ),
            SizedBox(
              height: 120.0,
            ),
            TextField(
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  hintText: 'Username',
                  border: InputBorder.none,
                  hintStyle: (TextStyle(
                    color: Colors.white,
                  )),
                  filled: true,
                  fillColor: lightPinkColor),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Password',
                border: InputBorder.none,
                hintStyle: (TextStyle(
                  color: Colors.white,
                )),
                filled: true,
                fillColor: lightPinkColor,
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 40.0,
            ),
            ButtonTheme(
              minWidth: 100,
              height: 50,
              child: (RaisedButton(
                color: lightPinkColor,
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _authenticate,
              )),
            ),
          ],
        ),
      ),
    );
  }

  /// method used to check if user authenticated correctly
  void _authenticate() {
    return;
  }
}
