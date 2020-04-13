import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class User {
  String userID;
  String status = "Just created my WaifuHub account!";
  String username;
  String email;
  String apiKey = "";
  List<dynamic> hubIDs = [];
  String profPicUrl;

  User({
    this.userID,
    this.status,
    this.username,
    this.email,
    this.apiKey,
    this.hubIDs,
    this.profPicUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        userID: json["userId"],
        status: json["status"],
        username: json["username"],
        email: json["email"],
        apiKey: json["apiKey"],
        hubIDs: json["hubs"],
        profPicUrl: json["profPicUrl"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "status": status,
        "username": username,
        "email": email,
        "apiKey": apiKey,
        "hubIDs": hubIDs,
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
      'hubIDs': [],
      'profPicUrl': profPicUrl,
    });
  }

  User userFromJson(String str) {
    final jsonData = json.decode(str);
    return User.fromJson(jsonData);
  }

  String userToJson(User data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }
}
