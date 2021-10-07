// To parse this JSON data, do
//
//     final currentUserSubscriptionModel = currentUserSubscriptionModelFromJson(jsonString);

import 'dart:convert';

CurrentUserSubscriptionModel currentUserSubscriptionModelFromJson(String str) =>
    CurrentUserSubscriptionModel.fromJson(json.decode(str));

String currentUserSubscriptionModelToJson(CurrentUserSubscriptionModel data) =>
    json.encode(data.toJson());

class CurrentUserSubscriptionModel {
  CurrentUserSubscriptionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory CurrentUserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserSubscriptionModel(
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
    required this.planName,
    required this.duration,
    required this.totalChat,
    required this.amount,
    required this.planExpire,
  });

  String userId;
  String planName;
  String duration;
  String totalChat;
  String amount;
  String planExpire;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        planName: json["plan_name"],
        duration: json["duration"],
        totalChat: json["total_chat"],
        amount: json["amount"],
        planExpire: json["Plan_Expire"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "plan_name": planName,
        "duration": duration,
        "total_chat": totalChat,
        "amount": amount,
        "Plan_Expire": planExpire,
      };
}
