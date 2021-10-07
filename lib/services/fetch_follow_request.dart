import 'dart:convert';
import 'package:find_friend/models/get_follow_request_model.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/get_follow_request.php';

class FollowRequestServices {
  static Future<GetFollowReqModel> getRequests(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid},
    );
    print('Get follow request services called ' + response.body);
    if (response.statusCode == 200) {
      return GetFollowReqModel.fromJson(jsonDecode(response.body));
    } else {
      return GetFollowReqModel.fromJson(jsonDecode(response.body));
    }
  }
}
