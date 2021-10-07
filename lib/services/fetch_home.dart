import 'dart:convert';
import 'package:find_friend/models/homes.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/home.php';
const String urll =
    'http://findfriend.notionprojects.tech/api/vip_user_home.php';

class HomeServices {
  static Future<Homes> getHome(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid},
    );
    print('home_screen services called ' + response.body);
    if (response.statusCode == 200) {
      return Homes.fromJson(jsonDecode(response.body));
    } else {
      return Homes.fromJson(jsonDecode(response.body));
    }
  }

  static Future<Homes> getVIP(String userid) async {
    var response = await http.post(
      Uri.parse(urll),
      body: {'token': '123456789', 'user_id': userid},
    );
    print('VIP_screen services called ' + response.body);
    if (response.statusCode == 200) {
      return Homes.fromJson(jsonDecode(response.body));
    } else {
      return Homes.fromJson(jsonDecode(response.body));
    }
  }
}
