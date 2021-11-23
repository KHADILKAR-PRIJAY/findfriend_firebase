import 'dart:convert';
import 'package:find_friend/models/others_profile.dart';
import 'package:find_friend/models/profile_model.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/get_profile.php';
const String urll =
    'http://findfriend.notionprojects.tech/api/others_users_profile.php';

class ProfileServices {
  static Future<Profile> getProfile(String username) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': username},
    );
    print(' get profile services called' + response.body);
    print('id: ' + username);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      return Profile.fromJson(jsonDecode(response.body));
    }
  }

  // static Future<OthersProfile> getOthersProfile(String username) async {
  //   var response = await http.post(Uri.parse(urll),
  //       body: {'username': username, 'token': '123456789'});
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     return OthersProfile.fromJson(jsonDecode(response.body));
  //   } else {
  //     return OthersProfile.fromJson(jsonDecode(response.body));
  //   }
  // }

  static Future<OthersProfile> getOthersProfileTwo(String userId) async {
    var response = await http
        .post(Uri.parse(urll), body: {'user_id': userId, 'token': '123456789'});
    print(response.body);
    if (response.statusCode == 200) {
      return OthersProfile.fromJson(jsonDecode(response.body));
    } else {
      return OthersProfile.fromJson(jsonDecode(response.body));
    }
  }
}
