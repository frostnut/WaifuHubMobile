import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hub {
  String id;
  int likes = 0;
  List<dynamic> commentIDs = [];
  String hubname;
  String description;
  String imageUrl;

  Hub(
      {this.id,
      likes,
      this.commentIDs,
      this.hubname,
      this.description,
      this.imageUrl});

  factory Hub.fromJson(Map<String, dynamic> json) => new Hub(
        id: json["id"],
        likes: json["likes"],
        commentIDs: json["comments"],
        hubname: json["hubname"],
        description: json["description"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "likes": likes,
        "comments": commentIDs,
        "hubname": hubname,
        "description": description,
        "imageUrl": imageUrl,
      };

  factory Hub.fromDocument(DocumentSnapshot doc) {
    return Hub.fromJson(doc.data);
  }
  void createHub(Firestore firestore, String key, String hubname,
      String description, String imageUrl) {
    firestore.collection("hubs").document(key).setData({
      "id": key,
      "likes": 0,
      "comments": [],
      "hubname": hubname,
      "description": description,
      "imageUrl": imageUrl,
    });
  }

  Hub hubFromJson(String str) {
    final jsonData = json.decode(str);
    return Hub.fromJson(jsonData);
  }

  String hubToJson(Hub data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }
}
