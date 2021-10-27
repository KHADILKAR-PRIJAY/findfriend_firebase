import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'http://findfriend.notionprojects.tech/api/add_call.php';

class NewCallServices {
  Future add_call({
    String? user_id,
    String? caller_id,
    String? call_type,
    String? call_duration,
    String? call_status,
  }) async {
    var response = await http.post(Uri.parse(url), body: {
      'token': '123456789',
      'user_id': user_id,
      'caller_id': caller_id,
      'call_type': call_type,
      'call_duration': call_duration,
      'call_status': call_status,
    });
    var Response = jsonDecode(response.body);
    print(Response);
  }
}
