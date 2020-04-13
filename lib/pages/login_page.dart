import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/widgets/registration_form_text_field.dart';
import 'package:WaifuHub/widgets/show_logo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/bottom_nav_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailInputController;
  TextEditingController _pwdInputController;

  @override
  initState() {
    _emailInputController = new TextEditingController();
    _pwdInputController = new TextEditingController();
    super.initState();
  }

  String _emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String _pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightPinkColor,
        title: Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: <Widget>[
                showLogo("assets/img/default.png"),
                registrationTextFormField(
                    'Email*', _emailInputController, _emailValidator, false),
                registrationTextFormField(
                    "Password*", _pwdInputController, _pwdValidator, true),
                RaisedButton(
                  child: Text("Login"),
                  color: lightPinkColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_loginFormKey.currentState.validate()) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailInputController.text,
                              password: _pwdInputController.text)
                          .then((currentUser) => Firestore.instance
                              .collection("users")
                              .document(currentUser.user.uid)
                              .get()
                              .then(
                                (DocumentSnapshot result) =>
                                    Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationBarController(
                                      uid: currentUser.user.uid,
                                    ),
                                  ),
                                ),
                              )
                              .catchError((err) => print(err)))
                          .catchError((err) => print(err));
                    }
                  },
                ),
                Text("Don't have an account yet?"),
                FlatButton(
                  child: Text("Register here!"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
