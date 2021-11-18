import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckBalanceServices {
  Future checkvideobalance() async {
    var response = await http.post(
        Uri.parse(
          'http://findfriend.notionprojects.tech/api/video_coins_deduct.php',
        ),
        body: {
          'token': '123456789',
          'user_id': '45',
        });
    var Response = jsonDecode(response.body);

    return Response;
  }

  Future checkaudiobalance() async {
    var response = await http.post(
        Uri.parse(
          'http://findfriend.notionprojects.tech/api/audio_coins_deduct.php',
        ),
        body: {
          'token': '123456789',
          'user_id': '45',
        });
    var Response = jsonDecode(response.body);
    return Response;
  }
}
