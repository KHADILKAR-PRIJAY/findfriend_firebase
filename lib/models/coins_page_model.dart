// To parse this JSON data, do
//
//     final coinsPageModel = coinsPageModelFromJson(jsonString);

import 'dart:convert';

CoinsPageModelProfile coinsPageModelFromJson(String str) =>
    CoinsPageModelProfile.fromJson(json.decode(str));

String coinsPageModelToJson(CoinsPageModelProfile data) =>
    json.encode(data.toJson());

class CoinsPageModelProfile {
  CoinsPageModelProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory CoinsPageModelProfile.fromJson(Map<String, dynamic> json) =>
      CoinsPageModelProfile(
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
    required this.totalCoins,
  });

  String id;
  String fullName;
  String username;
  String profilePicture;
  String totalCoins;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        profilePicture: json["profile_picture"],
        totalCoins: json["total_coins"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "profile_picture": profilePicture,
        "total_coins": totalCoins,
      };
}
