import 'dart:convert';
import 'package:http/http.dart' as http;

class CallRateServices {
  Map body = {'token': '123456789'};
  Future getAudiorate() async {
    var response = await http.post(
        Uri.parse(
            'http://findfriend.notionprojects.tech/api/audio_call_rate.php'),
        body: body);
    var Response = jsonDecode(response.body);
    return Response;
  }

  Future getVideorate() async {
    var response = await http.post(
        Uri.parse(
            'http://findfriend.notionprojects.tech/api/video_call_rate.php'),
        body: body);
    var Response = jsonDecode(response.body);
    return Response;
  }
}
