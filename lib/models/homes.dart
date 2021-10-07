/// status : true
/// message : "success"
/// data : [{"user_id":"122","full_name":"Miraj V","username":"tamaku","profile_image":"https://findfriend.notionprojects.tech/upload/profile/no_image.jpg","age":"25","city":"Jamnagar","gender":"Men","fcm_token":""},{"user_id":"126","full_name":"Deepika P","username":"deepu45","profile_image":"https://findfriend.notionprojects.tech/upload/profile/no_image.jpg","age":"42","city":"Jamnagar","gender":"Women","fcm_token":""},{"user_id":"132","full_name":"Rohit Sharma","username":"hitman45","profile_image":"https://findfriend.notionprojects.tech/upload/profile/no_image.jpg","age":"35","city":"Jamnagar","gender":"Men","fcm_token":""},{"user_id":"133","full_name":"M S Dhoni","username":"ms07","profile_image":"https://findfriend.notionprojects.tech/upload/profile/no_image.jpg","age":"30","city":"Jamnagar","gender":"Men","fcm_token":""},{"user_id":"135","full_name":"Anushka S","username":"anushka456","profile_image":"https://findfriend.notionprojects.tech/upload/profile/no_image.jpg","age":"29","city":"Jamnagar","gender":"Women","fcm_token":""}]

class Homes {
  bool? _status;
  String? _message;
  List<Data>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Homes({bool? status, String? message, List<Data>? data}) {
    _status = status;
    _message = message;
    _data = data;
  }

  Homes.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// user_id : "122"
/// full_name : "Miraj V"
/// username : "tamaku"
/// profile_image : "https://findfriend.notionprojects.tech/upload/profile/no_image.jpg"
/// age : "25"
/// city : "Jamnagar"
/// gender : "Men"
/// fcm_token : ""

class Data {
  String? _userId;
  String? _fullName;
  String? _username;
  String? _profileImage;
  String? _age;
  String? _city;
  String? _gender;
  String? _fcmToken;

  String? get userId => _userId;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get profileImage => _profileImage;
  String? get age => _age;
  String? get city => _city;
  String? get gender => _gender;
  String? get fcmToken => _fcmToken;

  Data(
      {String? userId,
      String? fullName,
      String? username,
      String? profileImage,
      String? age,
      String? city,
      String? gender,
      String? fcmToken}) {
    _userId = userId;
    _fullName = fullName;
    _username = username;
    _profileImage = profileImage;
    _age = age;
    _city = city;
    _gender = gender;
    _fcmToken = fcmToken;
  }

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _fullName = json['full_name'];
    _username = json['username'];
    _profileImage = json['profile_image'];
    _age = json['age'];
    _city = json['city'];
    _gender = json['gender'];
    _fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['full_name'] = _fullName;
    map['username'] = _username;
    map['profile_image'] = _profileImage;
    map['age'] = _age;
    map['city'] = _city;
    map['gender'] = _gender;
    map['fcm_token'] = _fcmToken;
    return map;
  }
}
