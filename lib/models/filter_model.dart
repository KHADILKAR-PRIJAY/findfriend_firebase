// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.interested,
    required this.age,
    required this.city,
  });

  String userId;
  String interested;
  String age;
  String city;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        interested: json["interested"],
        age: json["age"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "interested": interested,
        "age": age,
        "city": city,
      };
}
