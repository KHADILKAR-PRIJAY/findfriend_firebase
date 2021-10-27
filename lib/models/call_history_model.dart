// To parse this JSON data, do
//
//     final callingHistory = callingHistoryFromJson(jsonString);

import 'dart:convert';

CallingHistory callingHistoryFromJson(String str) =>
    CallingHistory.fromJson(json.decode(str));

String callingHistoryToJson(CallingHistory data) => json.encode(data.toJson());

class CallingHistory {
  CallingHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory CallingHistory.fromJson(Map<String, dynamic> json) => CallingHistory(
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
    required this.callerId,
    required this.fullName,
    required this.callType,
    required this.callDuration,
    required this.callDateTime,
    required this.callStatus,
  });

  String userId;
  String callerId;
  String fullName;
  String callType;
  String callDuration;
  DateTime callDateTime;
  String callStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        callerId: json["caller_id"],
        fullName: json["full_name"],
        callType: json["call_type"],
        callDuration: json["call_duration"],
        callDateTime: DateTime.parse(json["call_date_time"]),
        callStatus: json["call_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "caller_id": callerId,
        "full_name": fullName,
        "call_type": callType,
        "call_duration": callDuration,
        "call_date_time": callDateTime.toIso8601String(),
        "call_status": callStatus,
      };
}
