import 'dart:convert';
import 'package:find_friend/models/coins_page_model.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/get_users_coins.php';
//http://findfriend.notionprojects.tech/api/get_users_coins.php

class CoinPageServices {
  static Future<CoinsPageModelProfile> getCoinPage(String userid) async {
    var response = await http
        .post(Uri.parse(url), body: {'token': '123456789', 'user_id': userid});
    print('Get users coins Page services called' + response.body);
    if (response.statusCode == 200) {
      return CoinsPageModelProfile.fromJson(jsonDecode(response.body));
    } else {
      return CoinsPageModelProfile.fromJson(jsonDecode(response.body));
    }
  }
}
