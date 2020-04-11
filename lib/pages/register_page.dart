import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/widgets/bottomNavBar.dart';
import 'package:WaifuHub/widgets/show_logo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController usernameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  final databaseReference = FirebaseDatabase.instance.reference();
  File _image;
  String _uploadedFileURL;

  @override
  initState() {
    usernameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

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
                  showLogo(),
                  TextFormField(
                    cursorColor: lightPinkColor,
                    decoration: InputDecoration(
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      labelText: 'Username*',
                      labelStyle: textForm,
                    ),
                    controller: usernameInputController,
                  ),
                  TextFormField(
                    cursorColor: lightPinkColor,
                    decoration: InputDecoration(
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      labelText: 'Email*',
                      labelStyle: textForm,
                    ),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  TextFormField(
                    cursorColor: lightPinkColor,
                    decoration: InputDecoration(
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      labelText: 'Password*',
                      labelStyle: textForm,
                    ),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  TextFormField(
                    cursorColor: lightPinkColor,
                    decoration: InputDecoration(
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: lightPinkColor,
                        ),
                      ),
                      labelText: 'Confirm Password*',
                      labelStyle: textForm,
                    ),
                    controller: confirmPwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  Container(
                    height: 10,
                  ),
                  RaisedButton(
                    child: Text("Pick a profile pic"),
                    color: lightPinkColor,
                    textColor: Colors.white,
                    onPressed: chooseFile,
                  ),
                  RaisedButton(
                    child: Text("Register"),
                    color: lightPinkColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_registerFormKey.currentState.validate()) {
                        if (pwdInputController.text ==
                            confirmPwdInputController.text) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: pwdInputController.text)
                              .then((currentUser) => _saveUserRef(
                                    databaseReference,
                                    currentUser.user.uid,
                                    usernameInputController.text,
                                    emailInputController.text,
                                  )
                                      .then((result) => {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomNavigationBarController(
                                                          uid: currentUser
                                                              .user.uid,
                                                        )),
                                                (_) => false),
                                            usernameInputController.clear(),
                                            emailInputController.clear(),
                                            pwdInputController.clear(),
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
                                    )
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
                  )
                ],
              ),
            ))));
  }

  /// used to save the user profile into the firebase database
  /// TODO: implement firestore storage for account profile pictures
  Future<String> _saveUserRef(DatabaseReference databaseReference,
      String userID, String username, String email) async {
    String url = await uploadFile(userID);
    User newUser = new User(
        userID: userID, username: username, email: email, profPicUrl: url);
    newUser.createUser(databaseReference, userID, username, email, url);
    return newUser.userID;
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future<String> uploadFile(String uID) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('users/$uID');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    String url = downUrl.toString();
    return url;
  }
}
