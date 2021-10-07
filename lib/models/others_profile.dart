// To parse this JSON data, do
//
//     final othersProfile = othersProfileFromJson(jsonString);

import 'dart:convert';

OthersProfile othersProfileFromJson(String str) =>
    OthersProfile.fromJson(json.decode(str));

String othersProfileToJson(OthersProfile data) => json.encode(data.toJson());

class OthersProfile {
  OthersProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory OthersProfile.fromJson(Map<String, dynamic> json) => OthersProfile(
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
    required this.fullName,
    required this.username,
    required this.bio,
    required this.profilePicture,
    required this.age,
    required this.gender,
    required this.city,
    required this.qualification,
    required this.height,
    required this.birthday,
    required this.maritalStatus,
    required this.isConfirm,
    required this.requestSent,
    required this.fbLink,
    required this.instaLink,
    required this.youtubeLink,
    required this.twitterLink,
    required this.fcmToken,
  });

  String userId;
  String fullName;
  String username;
  String bio;
  String profilePicture;
  String age;
  String gender;
  String city;
  String qualification;
  String height;
  String birthday;
  String maritalStatus;
  String isConfirm;
  String requestSent;
  String fbLink;
  String instaLink;
  String youtubeLink;
  String twitterLink;
  String fcmToken;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        fullName: json["full_name"],
        username: json["username"],
        bio: json["bio"],
        profilePicture: json["profile_picture"],
        age: json["age"],
        gender: json["gender"],
        city: json["city"],
        qualification: json["qualification"],
        height: json["height"],
        birthday: json["birthday"],
        maritalStatus: json["marital_status"],
        isConfirm: json["is_confirm"],
        requestSent: json["request_sent"],
        fbLink: json["fb_link"],
        instaLink: json["insta_link"],
        youtubeLink: json["youtube_link"],
        twitterLink: json["twitter_link"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "username": username,
        "bio": bio,
        "profile_picture": profilePicture,
        "age": age,
        "gender": gender,
        "city": city,
        "qualification": qualification,
        "height": height,
        "birthday": birthday,
        "marital_status": maritalStatus,
        "is_confirm": isConfirm,
        "request_sent": requestSent,
        "fb_link": fbLink,
        "insta_link": instaLink,
        "youtube_link": youtubeLink,
        "twitter_link": twitterLink,
        "fcm_token": fcmToken,
      };
}
