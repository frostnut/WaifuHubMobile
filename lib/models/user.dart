import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import './hub.dart';

class User {
  String userID;
  String status = "";
  String username;
  String email;
  String apiKey = "";
  List<String> hubIDs;
  String profPicUrl;

  User({
    this.userID,
    status,
    this.username,
    this.email,
    apiKey,
    hubs,
    this.profPicUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        userID: json["userId"],
        status: json["status"],
        username: json["username"],
        email: json["email"],
        apiKey: json["apiKey"],
        hubs: json["hubs"],
        profPicUrl: json["profPicUrl"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "status": status,
        "username": username,
        "email": email,
        "apiKey": apiKey,
        "hubs": hubIDs,
        "profPicUrl": profPicUrl,
      };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }

  void createUser(Firestore firestore, String userID, String username,
      String email, String profPicUrl) {
    var key = randomAlphaNumeric(30);
    firestore.collection("users").document(userID).setData({
      'userID': userID,
      'status': status,
      'username': username,
      'email': email,
      'apiKey': key,
      'hubs': [],
      'profPicUrl': profPicUrl,
    });
  }
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
