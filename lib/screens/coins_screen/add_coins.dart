import 'dart:convert';
import 'package:find_friend/components/coin_box.dart';
import 'package:find_friend/models/coins_plan.dart';
import 'package:find_friend/services/fetch_coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

const String urll =
    'http://findfriend.notionprojects.tech/api/iniInitiate_transaction.php';
const String url = 'http://findfriend.notionprojects.tech/api/add_coins.php';
const String url2 =
    'http://findfriend.notionprojects.tech/api/transaction_status.php';

class AddCoins extends StatefulWidget {
  static String id = 'add_coins';
  late final String userid;
  AddCoins(this.userid);

  @override
  _AddCoinsState createState() => _AddCoinsState();
}

class _AddCoinsState extends State<AddCoins> {
  late Future<CoinsPlan> coinsplan;
  String mid = "", orderId = "", amount = "", txnToken = "";
  String result = "";
  bool isStaging = true;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = true;
  bool enableAssist = true;
  late String paymentStatusCode;

  Future addCoins(
      String userid, String credAmount, BuildContext context) async {
    var Response = await http.post(Uri.parse(url), body: {
      'token': '123456789',
      'user_id': userid,
      'credit_amount': credAmount
    });
    print('Add coins services called' + Response.body);
    var response = jsonDecode(Response.body);
    if (response['status']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: Colors.green,
          content: Text('${credAmount} ${response['message']} ',
              textAlign: TextAlign.center)));
    } else {
      print('Coins cannot be added');
    }
  }

  Future<void> getTxnToken(String amount, String totalCoin) async {
    var Response = await http.post(Uri.parse(urll), body: {
      'token': '123456789',
      'amount': amount,
    });
    var response = jsonDecode(Response.body);
    if (Response.statusCode == 200) {
      print('Get transaction token : ' + Response.body);
      orderId = response['data']['orderId'];
      mid = response['data']['mid'];
      txnToken = response['data']['response']['body']['txnToken'];
      _startTransaction(amount).then((value) {
        checkPaymentStatus(orderId).then((value) {
          if (paymentStatusCode == '01') {
            addCoins(widget.userid, totalCoin, context).then((value) {
              setState(() {
                coinsplan = CoinServices.getCoins(widget.userid);
              });
            });
          }
        });
      });
    } else {
      print('error');
    }
  }

  Future<void> checkPaymentStatus(String orderId) async {
    var Response = await http.post(Uri.parse(url2), body: {
      'token': '123456789',
      'order_id': orderId,
    });
    var response = jsonDecode(Response.body);
    if (Response.statusCode == 200) {
      debugPrint(' checkPaymentStatus: ' + Response.body);
      setState(() {
        paymentStatusCode =
            response['data']['response']['body']['resultInfo']['resultCode'];
      });
    } else {
      print('error');
    }
  }

  Future<void> _startTransaction(String amount) async {
    // if (txnToken.isEmpty) {
    //   return print('txn token is empty!');
    // }
    // var sendMap = <String, dynamic>{
    //   "mid": mid,
    //   "orderId": orderId,
    //   "amount": amount,
    //   "txnToken": txnToken,
    //   "callbackUrl":
    //       'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=${orderId}',
    //   "isStaging": isStaging,
    //   "restrictAppInvoke": restrictAppInvoke,
    //   "enableAssist": enableAssist
    // };
    // print('Data map for paytm: ' + sendMap.toString());

    var response = await AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount,
        txnToken,
        "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=${orderId}",
        isStaging,
        restrictAppInvoke,
        enableAssist);
    //     .then((value) {
    //   print(value);
    //
    //   // setState(() {
    //   //   //result = value.toString();
    //   // });
    // });
    //       .catchError((onError) {
    //     if (onError is PlatformException) {
    //       setState(() {
    //         result = onError.message.toString() +
    //             " \n  " +
    //             onError.details.toString();
    //       });
    //     } else {
    //       setState(() {
    //         result = onError.toString();
    //       });
    //     }
    //   });
    // } catch (err) {
    //   result = err.toString();
    // }
  }

  @override
  void initState() {
    coinsplan = CoinServices.getCoins(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Add Coins'),
        centerTitle: true,
      ),
      body: FutureBuilder<CoinsPlan>(
          future: coinsplan,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Total Coins',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.orange[300],
                            radius: 7,
                            child: Text(
                              '\u{20B9}',
                              style:
                                  TextStyle(fontSize: 9, color: Colors.black),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:
                              Text('${snapshot.data!.data[0].userTotalCoins}'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Center(
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 120,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                ),
                                itemCount: snapshot.data!.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        getTxnToken(
                                            '${snapshot.data!.data[index].amount}',
                                            '${snapshot.data!.data[index].totalCoin}');
                                        //     .then((value) {
                                        //   if (paymentStatusCode == '01') {
                                        //     addCoins(
                                        //             widget.userid,
                                        //             '${snapshot.data!.data[index].totalCoin}',
                                        //             context)
                                        //         .then((value) {
                                        //       setState(() {
                                        //         coinsplan =
                                        //             CoinServices.getCoins(
                                        //                 widget.userid);
                                        //       });
                                        //     });
                                        //   } else {
                                        //     print(
                                        //         'hhhhhhhhhhhhhhhuhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh!');
                                        //   }
                                        // });
                                      });
                                    },
                                    child: CoinBox(
                                        price:
                                            '${snapshot.data!.data[index].amount}',
                                        coins:
                                            '${snapshot.data!.data[index].totalCoin}'),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 5),
                            child: Text('Choose Your Plan',
                                style: TextStyle(color: Colors.grey)),
                          )
                        ],
                      ),
                    ),
                    height: 330,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
//Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             CoinBox(
//                                 price: '${snapshot.data!.data[0].totalCoin}',
//                                 coins: '${snapshot.data!.data[0].amount}'),
//                             CoinBox(
//                                 price: '${snapshot.data!.data[0].totalCoin}',
//                                 coins: '${snapshot.data!.data[0].amount}'),
//                             CoinBox(
//                                 price: '${snapshot.data!.data[0].totalCoin}',
//                                 coins: '${snapshot.data!.data[0].amount}'),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             CoinBox(
//                                 price: '${snapshot.data!.data[0].totalCoin}',
//                                 coins: '${snapshot.data!.data[0].amount}'),
//                             CoinBox(
//                                 price: '${snapshot.data!.data[0].totalCoin}',
//                                 coins: '${snapshot.data!.data[0].amount}'),
//                             CoinBox(
//                                 price: '${snapshot.data!.data[0].totalCoin}',
//                                 coins: '${snapshot.data!.data[0].amount}'),
//                           ],
//                         ),
//                         Text(
//                           'Choose Your Plan',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     )
