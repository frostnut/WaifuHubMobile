import 'package:WaifuHub/global/assets.dart';
import 'package:WaifuHub/pages/splash_page.dart';
import 'package:WaifuHub/widgets/show_logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/hub.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/registration_form_text_field.dart';
import 'package:random_string/random_string.dart';

/// allows user to register a new hub
/// much of the logic is repeated from register
/// page
class HubCreatePage extends StatefulWidget {
  HubCreatePage({Key key}) : super(key: key);

  @override
  _HubCreatePageState createState() => _HubCreatePageState();
}

class _HubCreatePageState extends State<HubCreatePage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController;
  TextEditingController descriptionInputController;
  final firestoreInstance = Firestore.instance;
  final databaseReference = FirebaseDatabase.instance.reference();
  File _image;

  @override
  initState() {
    nameInputController = new TextEditingController();
    descriptionInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightPinkColor,
        centerTitle: true,
        title: Text(
          "Create a Hub",
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
                showLogo("assets/img/default2.png"),
                registrationTextFormField(
                    "Hub Name*", nameInputController, null, false),
                registrationTextFormField(
                    "Hub Description*", descriptionInputController, null, false),
                Container(
                  height: 10,
                ),
                RaisedButton(
                  child: Text("Pick a hub pic"),
                  color: lightPinkColor,
                  textColor: Colors.white,
                  onPressed: chooseFile,
                ),
                RaisedButton(
                  child: Text("Create a Hub"),
                  color: lightPinkColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _saveHub(
                      databaseReference,
                      nameInputController.text,
                      descriptionInputController.text,
                    ).then(
                      (_) => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashPage()),
                            (_) => false),
                        nameInputController.clear(),
                        descriptionInputController.clear(),
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// passes all needed params to create a new hub then creates it in firestore
  /// instance
  Future<String> _saveHub(DatabaseReference databaseReference, String hubname,
      String description) async {
    var key = randomAlphaNumeric(30);
    String picUrl = await uploadFile(key);
    Hub newHub = new Hub(hubname: hubname, description: description);
    newHub.createHub(firestoreInstance, key, hubname, description, picUrl);
  }

  /// file picker from gallery
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  /// uploads file to firestore storage
  Future<String> uploadFile(String hubID) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('hub/$hubID');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    String url = downUrl.toString();
    return url;
  }
}
