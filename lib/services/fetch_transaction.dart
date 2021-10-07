import 'dart:convert';
import 'package:find_friend/models/transaction_model.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/transaction_history.php';

class TransactionServices {
  static Future<TransactionModel> getHistory(String userid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid},
    );
    print('Transaction History called' + response.body);
    if (response.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      return TransactionModel.fromJson(jsonDecode(response.body));
    }
  }
}
