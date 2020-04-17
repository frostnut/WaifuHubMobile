import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../global/assets.dart';
import '../models/user.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/registration_form_text_field.dart';
import '../widgets/show_logo.dart';

/// Register page handles logic for registering a user
/// register a user requires a username, email, password
/// and for a profile picture to be selected
class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController _usernameInputController;
  TextEditingController _emailInputController;
  TextEditingController _pwdInputController;
  TextEditingController _confirmPwdInputController;
  final _firestoreInstance = Firestore.instance;
  final _databaseReference = FirebaseDatabase.instance.reference();
  File _image;

  @override
  initState() {
    _usernameInputController = new TextEditingController();
    _emailInputController = new TextEditingController();
    _pwdInputController = new TextEditingController();
    _confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  /// used to validate email input
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  /// used to validate password input
  String pwdValidator(String value) {
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
        backgroundColor: lightPinkColor,
        centerTitle: true,
        title: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                showLogo("assets/img/default.png"),
                registrationTextFormField(
                    "Username*", _usernameInputController, null, false),
                registrationTextFormField(
                    "Email*", _emailInputController, emailValidator, false),
                registrationTextFormField(
                    "Password*", _pwdInputController, pwdValidator, true),
                registrationTextFormField("Confirm Password*",
                    _confirmPwdInputController, pwdValidator, true),
                Container(
                  height: 10,
                ),
                RaisedButton(
                  child: Text("Pick a profile pic"),
                  color: lightPinkColor,
                  textColor: Colors.white,
                  onPressed: _chooseFile,
                ),
                RaisedButton(
                  child: Text("Register"),
                  color: lightPinkColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_registerFormKey.currentState.validate()) {
                      if (_pwdInputController.text ==
                          _confirmPwdInputController.text) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailInputController.text,
                                password: _pwdInputController.text)
                            .then((currentUser) => _saveUserRef(
                                  _databaseReference,
                                  currentUser.user.uid,
                                  _usernameInputController.text,
                                  _emailInputController.text,
                                )
                                    .then((result) => {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavigationBarController(
                                                  uid: currentUser.user.uid,
                                                ),
                                              ),
                                              (_) => false),
                                          _usernameInputController.clear(),
                                          _emailInputController.clear(),
                                          _pwdInputController.clear(),
                                        })
                                    .catchError((err) => print(err)))
                            .catchError((err) => print(err));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("The passwords do not match"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    }
                  },
                ),
                Text("Already have an account?"),
                FlatButton(
                  child: Text("Login here!"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// used to save the user profile into the firebase database
  /// also calls the upload of the profile picture and saves the
  /// download url in user ref
  Future<String> _saveUserRef(DatabaseReference databaseReference,
      String userID, String username, String email) async {
    String url = await _uploadFile(userID);
    User newUser = new User(
        userID: userID, username: username, email: email, profPicUrl: url);
    newUser.createUser(_firestoreInstance, userID, username, email, url);
    return newUser.userID;
  }

  /// file picker from gallery
  Future _chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  /// uploads file to firestore storage
  Future<String> _uploadFile(String uID) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('users/$uID');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    String url = downUrl.toString();
    return url;
  }
}
