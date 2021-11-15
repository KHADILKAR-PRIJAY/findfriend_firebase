// To parse this JSON data, do
//
//     final paytmTransactionModel = paytmTransactionModelFromJson(jsonString);

import 'dart:convert';

PaytmTransactionModel paytmTransactionModelFromJson(String str) =>
    PaytmTransactionModel.fromJson(json.decode(str));

String paytmTransactionModelToJson(PaytmTransactionModel data) =>
    json.encode(data.toJson());

class PaytmTransactionModel {
  PaytmTransactionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory PaytmTransactionModel.fromJson(Map<String, dynamic> json) =>
      PaytmTransactionModel(
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
    required this.response,
    required this.orderId,
    required this.mid,
  });

  Response response;
  String orderId;
  String mid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        response: Response.fromJson(json["response"]),
        orderId: json["orderId"],
        mid: json["mid"],
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "orderId": orderId,
        "mid": mid,
      };
}

class Response {
  Response({
    required this.head,
    required this.body,
  });

  Head head;
  Body body;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        head: Head.fromJson(json["head"]),
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "head": head.toJson(),
        "body": body.toJson(),
      };
}

class Body {
  Body({
    required this.resultInfo,
    required this.txnToken,
    required this.isPromoCodeValid,
    required this.authenticated,
  });

  ResultInfo resultInfo;
  String txnToken;
  bool isPromoCodeValid;
  bool authenticated;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        resultInfo: ResultInfo.fromJson(json["resultInfo"]),
        txnToken: json["txnToken"],
        isPromoCodeValid: json["isPromoCodeValid"],
        authenticated: json["authenticated"],
      );

  Map<String, dynamic> toJson() => {
        "resultInfo": resultInfo.toJson(),
        "txnToken": txnToken,
        "isPromoCodeValid": isPromoCodeValid,
        "authenticated": authenticated,
      };
}

class ResultInfo {
  ResultInfo({
    required this.resultStatus,
    required this.resultCode,
    required this.resultMsg,
  });

  String resultStatus;
  String resultCode;
  String resultMsg;

  factory ResultInfo.fromJson(Map<String, dynamic> json) => ResultInfo(
        resultStatus: json["resultStatus"],
        resultCode: json["resultCode"],
        resultMsg: json["resultMsg"],
      );

  Map<String, dynamic> toJson() => {
        "resultStatus": resultStatus,
        "resultCode": resultCode,
        "resultMsg": resultMsg,
      };
}

class Head {
  Head({
    required this.responseTimestamp,
    required this.version,
    required this.signature,
  });

  String responseTimestamp;
  String version;
  String signature;

  factory Head.fromJson(Map<String, dynamic> json) => Head(
        responseTimestamp: json["responseTimestamp"],
        version: json["version"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "responseTimestamp": responseTimestamp,
        "version": version,
        "signature": signature,
      };
}
