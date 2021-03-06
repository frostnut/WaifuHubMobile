import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';

class Comment {
  String id;
  int likes = 0;
  String hubId;
  String userId;
  String text;
  String stamp;

  Comment({this.id, this.userId, this.likes, this.hubId, this.text, stamp});

  factory Comment.fromJson(Map<String, dynamic> json) => new Comment(
        id: json["id"],
        likes: json["likes"],
        hubId: json["hubId"],
        userId: json["userId"],
        text: json["text"],
        stamp: json["stamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "likes": likes,
        "hubId": hubId,
        "userId": userId,
        "text": text,
        "stamp": stamp,
      };

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment.fromJson(doc.data);
  }
  Comment commentFromJson(String str) {
    final jsonData = json.decode(str);
    return Comment.fromJson(jsonData);
  }

  String commentToJson(Comment data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }

  void createComment(
      Firestore firestore, String hubId, String userId, String text) {
    var key = randomAlphaNumeric(30);
    this.id = key;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    this.stamp = formattedDate;
    firestore.collection("comments").document(key).setData({
      'id': key,
      'likes': 0,
      'text': text,
      'hubId': hubId,
      'userId': userId,
      'stamp': formattedDate,
    });
  }
}
