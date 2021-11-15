// import 'dart:convert';
// import 'package:find_friend/models/paytm_transaction_model.dart';
// import 'package:http/http.dart' as http;
//
// const String url =
//     'http://findfriend.notionprojects.tech/api/iniInitiate_transaction.php';
//
// class PaytmTransaction {
//   static Future<PaytmTransactionModel> transaction(String amount) async {
//     var response = await http.post(
//       Uri.parse(url),
//       body: {'token': '123456789', 'amount': amount},
//     );
//     print('Initiate transaction called' + response.body);
//     if (response.statusCode == 200) {
//       return Data.fromJson(jsonDecode(response.body));
//     } else {
//       return Data.fromJson(jsonDecode(response.body));
//     }
//   }
// }
