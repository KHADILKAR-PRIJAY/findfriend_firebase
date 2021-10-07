// To parse this JSON data, do
//
//     final followingListModel = followingListModelFromJson(jsonString);

import 'dart:convert';

FollowingListModel followingListModelFromJson(String str) =>
    FollowingListModel.fromJson(json.decode(str));

String followingListModelToJson(FollowingListModel data) =>
    json.encode(data.toJson());

class FollowingListModel {
  FollowingListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory FollowingListModel.fromJson(Map<String, dynamic> json) =>
      FollowingListModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.fullName,
    required this.username,
    required this.profilePicture,
  });

  String id;
  String fullName;
  String username;
  String profilePicture;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "profile_picture": profilePicture,
      };
}
