// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) =>
    json.encode(data.toJson());

class SubscriptionModel {
  SubscriptionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
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
    required this.planId,
    required this.planName,
    required this.duration,
    required this.totalChat,
    required this.amount,
  });

  String planId;
  String planName;
  String duration;
  String totalChat;
  String amount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        planId: json["plan_id"],
        planName: json["plan_name"],
        duration: json["duration"],
        totalChat: json["total_chat"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId,
        "plan_name": planName,
        "duration": duration,
        "total_chat": totalChat,
        "amount": amount,
      };
}
