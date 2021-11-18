// To parse this JSON data, do
//
//     final coinsPageModelProfile = coinsPageModelProfileFromJson(jsonString);

import 'dart:convert';

CoinsPageModelProfile coinsPageModelProfileFromJson(String str) =>
    CoinsPageModelProfile.fromJson(json.decode(str));

String coinsPageModelProfileToJson(CoinsPageModelProfile data) =>
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
    required this.isVip,
  });

  String id;
  String fullName;
  String username;
  String profilePicture;
  String totalCoins;
  String isVip;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        profilePicture: json["profile_picture"],
        totalCoins: json["total_coins"],
        isVip: json["is_vip"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "profile_picture": profilePicture,
        "total_coins": totalCoins,
        "is_vip": isVip,
      };
}
