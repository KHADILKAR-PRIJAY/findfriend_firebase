// To parse this JSON data, do
//
//     final followerListModel = followerListModelFromJson(jsonString);

import 'dart:convert';

FollowerListModel followerListModelFromJson(String str) =>
    FollowerListModel.fromJson(json.decode(str));

String followerListModelToJson(FollowerListModel data) =>
    json.encode(data.toJson());

class FollowerListModel {
  FollowerListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<FollowerListModelDatum> data;

  factory FollowerListModel.fromJson(Map<String, dynamic> json) =>
      FollowerListModel(
        status: json["status"],
        message: json["message"],
        data: List<FollowerListModelDatum>.from(
            json["data"].map((x) => FollowerListModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FollowerListModelDatum {
  FollowerListModelDatum({
    required this.id,
    required this.fullName,
    required this.username,
    required this.profilePicture,
  });

  String id;
  String fullName;
  String username;
  String profilePicture;

  factory FollowerListModelDatum.fromJson(Map<String, dynamic> json) =>
      FollowerListModelDatum(
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
