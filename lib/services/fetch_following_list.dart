import 'dart:convert';
import 'package:find_friend/models/following_list_model.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/following_list.php';

class FollowingListServices {
  static Future<FollowingListModel> getFollowingList(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid},
    );
    print('Following list services called: \n');
    print(response.body);
    if (response.statusCode == 200) {
      return FollowingListModel.fromJson(jsonDecode(response.body));
    } else {
      return FollowingListModel.fromJson(jsonDecode(response.body));
    }
  }
}
