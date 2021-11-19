import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckBalanceServices {
  Future checkvideobalance(String userid) async {
    var response = await http.post(
        Uri.parse(
          'http://findfriend.notionprojects.tech/api/video_coins_deduct.php',
        ),
        body: {
          'token': '123456789',
          'user_id': userid,
        });
    var Response = jsonDecode(response.body);

    return Response;
  }

  Future checkaudiobalance(String userid) async {
    var response = await http.post(
        Uri.parse(
          'http://findfriend.notionprojects.tech/api/audio_coins_deduct.php',
        ),
        body: {
          'token': '123456789',
          'user_id': userid,
        });
    var Response = jsonDecode(response.body);
    return Response;
  }
}
