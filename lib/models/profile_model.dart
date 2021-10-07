// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
    required this.following,
    required this.followers,
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
    required this.fbLink,
    required this.instaLink,
    required this.youtubeLink,
    required this.twitterLink,
  });

  String id;
  String following;
  String followers;
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
  String fbLink;
  String instaLink;
  String youtubeLink;
  String twitterLink;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        following: json["following"],
        followers: json["followers"],
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
        fbLink: json["fb_link"],
        instaLink: json["insta_link"],
        youtubeLink: json["youtube_link"],
        twitterLink: json["twitter_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "following": following,
        "followers": followers,
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
        "fb_link": fbLink,
        "insta_link": instaLink,
        "youtube_link": youtubeLink,
        "twitter_link": twitterLink,
      };
}
