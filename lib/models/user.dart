import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';

class User {
  String userID;
  String status = "";
  String username;
  String email;
  String apiKey = "";

  User({
    this.userID,
    status,
    this.username,
    this.email,
    apiKey,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        userID: json["userId"],
        status: json["status"],
        username: json["username"],
        email: json["email"],
        apiKey: json["apiKey"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "status": status,
        "username": username,
        "email": email,
        "apiKey": apiKey,
      };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }

  void createUser(DatabaseReference databaseReference, String userID,
      String username, String email) {
    var key = randomAlphaNumeric(30);
    databaseReference.child("users").child(userID).set({
      'userID': userID,
      'status': status,
      'username': username,
      'email': email,
      'apiKey': key,
    });
  }
}

User myDocFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String myDocToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
