// To parse this JSON data, do
//
//     final getFollowReqModel = getFollowReqModelFromJson(jsonString);

import 'dart:convert';

GetFollowReqModel getFollowReqModelFromJson(String str) =>
    GetFollowReqModel.fromJson(json.decode(str));

String getFollowReqModelToJson(GetFollowReqModel data) =>
    json.encode(data.toJson());

class GetFollowReqModel {
  GetFollowReqModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory GetFollowReqModel.fromJson(Map<String, dynamic> json) =>
      GetFollowReqModel(
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
    required this.userId,
    required this.followerId,
    required this.username,
    required this.fullName,
    required this.profileImage,
  });

  String userId;
  String followerId;
  String username;
  String fullName;
  String profileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        followerId: json["follower_id"],
        username: json["username"],
        fullName: json["full_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "follower_id": followerId,
        "username": username,
        "full_name": fullName,
        "profile_image": profileImage,
      };
}
