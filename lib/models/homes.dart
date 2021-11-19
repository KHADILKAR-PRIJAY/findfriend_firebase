// To parse this JSON data, do
//
//     final homes = homesFromJson(jsonString);

import 'dart:convert';

Homes homesFromJson(String str) => Homes.fromJson(json.decode(str));

String homesToJson(Homes data) => json.encode(data.toJson());

class Homes {
  Homes({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Data> data;

  factory Homes.fromJson(Map<String, dynamic> json) => Homes(
        status: json["status"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.userId,
    required this.fullName,
    required this.username,
    required this.profileImage,
    required this.age,
    required this.city,
    required this.gender,
    required this.fcmToken,
    required this.status,
  });

  String userId;
  String fullName;
  String username;
  String profileImage;
  String age;
  String city;
  String gender;
  String fcmToken;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        fullName: json["full_name"],
        username: json["username"],
        profileImage: json["profile_image"],
        age: json["age"],
        city: json["city"],
        gender: json["gender"],
        fcmToken: json["fcm_token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "username": username,
        "profile_image": profileImage,
        "age": age,
        "city": city,
        "gender": gender,
        "fcm_token": fcmToken,
        "status": status,
      };
}
