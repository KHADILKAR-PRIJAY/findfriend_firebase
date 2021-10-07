import 'dart:convert';
import 'package:find_friend/models/filter_model.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/date_filter.php';

class FilterServices {
  static Future<FilterModel> getFilter(
      {required String city,
      required String interested,
      required String minage,
      required String maxage,
      required String userid}) async {
    var response = await http.post(Uri.parse(url), body: {
      'token': '123456789',
      'user_id': userid,
      'city': city,
      'interested': interested,
      'min_age': minage,
      'max_age': maxage
    });
    print('coins_screen services called' + response.body);
    if (response.statusCode == 200) {
      return FilterModel.fromJson(jsonDecode(response.body));
    } else {
      return FilterModel.fromJson(jsonDecode(response.body));
    }
  }
}
