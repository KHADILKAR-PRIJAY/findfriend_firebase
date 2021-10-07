import 'dart:convert';
import 'package:http/http.dart' as http;

const URL = 'http://findfriend.notionprojects.tech/api/random_channel.php';

class generatechannel {
  Future GenerateChannel() async {
    var response =
        await http.post(Uri.parse(URL), body: {'token': '123456789'});
    var Response = jsonDecode(response.body);

    String channelname = Response['data']['Channel Name'];
    return channelname;
  }
}
