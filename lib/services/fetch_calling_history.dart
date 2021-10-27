import 'dart:convert';
import 'package:find_friend/models/call_history_model.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/get_call_history.php';

class CallHistoryServices {
  static Future<CallingHistory> getCallHistory(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {
        'token': '123456789',
        'user_id': userid,
      },
    );
    print('Calling history  services called' + response.body);
    if (response.statusCode == 200) {
      return CallingHistory.fromJson(jsonDecode(response.body));
    } else {
      return CallingHistory.fromJson(jsonDecode(response.body));
    }
  }
}
