import 'dart:convert';
import 'package:find_friend/models/coins_plan.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/get_coins.php';

class CoinServices {
  static Future<CoinsPlan> getCoins(String userid) async {
    var response = await http
        .post(Uri.parse(url), body: {'token': '123456789', 'user_id': userid});
    print('coins_screen services called' + response.body);
    if (response.statusCode == 200) {
      return CoinsPlan.fromJson(jsonDecode(response.body));
    } else {
      return CoinsPlan.fromJson(jsonDecode(response.body));
    }
  }
}
