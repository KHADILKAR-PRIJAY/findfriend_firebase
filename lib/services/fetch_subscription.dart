import 'dart:convert';
import 'package:find_friend/models/current_user_subscription_model.dart';
import 'package:find_friend/models/subscription_model.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/get_subscription_plan.php';
const String urll =
    'http://findfriend.notionprojects.tech/api/subscription.php';

class SubscriptionPlanServices {
  static Future<SubscriptionModel> getPlans() async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789'},
    );
    print('Subscription Plan services called');
    print(response.body);
    if (response.statusCode == 200) {
      return SubscriptionModel.fromJson(jsonDecode(response.body));
    } else {
      return SubscriptionModel.fromJson(jsonDecode(response.body));
    }
  }

  static Future<CurrentUserSubscriptionModel> getCurrentUserPlan(
      String userid) async {
    var response = await http.post(
      Uri.parse(urll),
      body: {'token': '123456789', 'user_id': userid},
    );
    print(" Current User's Subscription Plan services called");
    print('user id: ' + userid);
    print(response.body);
    if (response.statusCode == 200) {
      return CurrentUserSubscriptionModel.fromJson(jsonDecode(response.body));
    } else {
      return CurrentUserSubscriptionModel.fromJson(jsonDecode(response.body));
    }
  }
}
