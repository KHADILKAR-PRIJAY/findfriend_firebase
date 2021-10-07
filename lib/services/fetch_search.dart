import 'dart:convert';
import 'package:find_friend/models/search_model.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/search.php';

class SearchServices {
  static Future<SearchModel> getSearch(String username) async {
    var response = await http.post(
      Uri.parse(url),
      body: {
        'token': '123456789',
        'username': username,
      },
    );
    print('fetch services called' + response.body);
    print(username);
    print(response.body);
    if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    } else {
      return SearchModel.fromJson(jsonDecode(response.body));
    }
  }
}
