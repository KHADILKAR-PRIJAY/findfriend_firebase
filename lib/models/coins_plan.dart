// To parse this JSON data, do
//
//     final coinsPlan = coinsPlanFromJson(jsonString);

import 'dart:convert';

CoinsPlan coinsPlanFromJson(String str) => CoinsPlan.fromJson(json.decode(str));

String coinsPlanToJson(CoinsPlan data) => json.encode(data.toJson());

class CoinsPlan {
  CoinsPlan({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory CoinsPlan.fromJson(Map<String, dynamic> json) => CoinsPlan(
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
    required this.userTotalCoins,
    required this.planName,
    required this.totalCoin,
    required this.amount,
  });

  String userTotalCoins;
  String planName;
  String totalCoin;
  String amount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userTotalCoins: json["user_total_coins"],
        planName: json["plan_name"],
        totalCoin: json["total_coin"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "user_total_coins": userTotalCoins,
        "plan_name": planName,
        "total_coin": totalCoin,
        "amount": amount,
      };
}
