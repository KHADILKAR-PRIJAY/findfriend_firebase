// To parse this JSON data, do
//
//     final getPostModel = getPostModelFromJson(jsonString);

import 'dart:convert';

GetPostModel getPostModelFromJson(String str) =>
    GetPostModel.fromJson(json.decode(str));

String getPostModelToJson(GetPostModel data) => json.encode(data.toJson());

class GetPostModel {
  GetPostModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory GetPostModel.fromJson(Map<String, dynamic> json) => GetPostModel(
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
    required this.post,
  });

  String id;
  String post;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        post: json["post"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post": post,
      };
}
