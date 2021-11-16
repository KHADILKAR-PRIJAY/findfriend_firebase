import 'dart:convert';
import 'package:find_friend/models/follower_list_model.dart';

import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/followers_list.php';

class FollowerListServices {
  static Future<FollowerListModel> getFollowerList(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid},
    );
    print('Followers list services called: \n');
    print(response.body);
    if (response.statusCode == 200) {
      return FollowerListModel.fromJson(jsonDecode(response.body));
    } else {
      return FollowerListModel.fromJson(jsonDecode(response.body));
    }
  }

  static Future<List<FollowerListModel>> getimages(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid},
    );
    var rb = response.body;

    // store json data into list
    var list = json.decode(rb) as List;

    // iterate over the list and map each object in list to Img by calling Img.fromJson
    List<FollowerListModel> imgs =
        list.map((i) => FollowerListModel.fromJson(i)).toList();

    print(imgs.runtimeType); //returns List<Img>
    print(imgs[0].runtimeType); //returns Img

    return imgs;
  }
}
