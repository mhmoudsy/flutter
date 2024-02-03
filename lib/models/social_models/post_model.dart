import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostModel {
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? dataTime;
  String? text;
  String? postId;

  PostModel({
    this.uId,
    this.name,
    this.postImage,
    this.dataTime,
    this.text,
    this.image,
  });
  factory PostModel.fromDocument(DocumentSnapshot doc) {
    return PostModel(
      name: doc['name'],
      uId: doc['uId'],
      image: doc['image'],
      postImage: doc['postImage'],
      dataTime: doc['dataTime'],
      text: doc['text'],
    );
  }
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    dataTime = json['dataTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'dataTime': dataTime,
      'text': text,
    };
  }


}
