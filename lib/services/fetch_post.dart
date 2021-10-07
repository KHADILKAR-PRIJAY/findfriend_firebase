import 'dart:convert';
import 'package:find_friend/models/getpost_model.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/get_users_posts.php';

class PostServices {
  static Future<GetPostModel> getPost(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid},
    );
    print('getPost services called');
    print('user id: ' + userid);
    print(response.body);
    if (response.statusCode == 200) {
      return Future.value(GetPostModel.fromJson(jsonDecode(response.body)));
    } else {
      return Future.value(GetPostModel.fromJson(jsonDecode(response.body)));
    }
  }
}
