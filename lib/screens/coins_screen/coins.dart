import 'dart:convert';
import 'package:find_friend/models/coins_page_model.dart';
import 'package:find_friend/screens/coins_screen/add_coins.dart';
import 'package:find_friend/screens/transaction.dart';
import 'package:find_friend/services/fetch_coin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/redeem_coins.php';

class Coins extends StatefulWidget {
  static String id = 'coins_screen';
  late final String userid;
  Coins(this.userid);

  @override
  _CoinsState createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  late Future<CoinsPageModelProfile> coinspagemodel;
  TextEditingController coins_amountController = TextEditingController();

  Future reedemCoins(String userid, String debitamount) async {
    var Response = await http.post(Uri.parse(url), body: {
      'token': '123456789',
      'user_id': userid,
      'debit_amount': debitamount
    });
    print('Reedem coins services called' + Response.body);
    var response = jsonDecode(Response.body);
    if (response['status']) {
      final snackbar = SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: Colors.deepOrange,
          content: Text('${response['message']}', textAlign: TextAlign.center));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      final snackbar = SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: Colors.red,
          content: Text('${response['message']}', textAlign: TextAlign.center));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void initState() {
    setState(() {
      coinspagemodel = CoinPageServices.getCoinPage(widget.userid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Coins'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<CoinsPageModelProfile>(
            future: coinspagemodel,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFFD01B65),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 33,
                      child: CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                              '${snapshot.data!.data[0].profilePicture}')),
                    ),
                  ),
                  Text('${snapshot.data!.data[0].fullName}'),
                  Text(
                    '${snapshot.data!.data[0].username}',
                    style: TextStyle(color: Color(0xffF0EEEF).withOpacity(0.6)),
                  ),
                  Text(
                    'Total Coins',
                    style: TextStyle(color: Color(0xFFF0EEEF)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.orange[300],
                          radius: 7,
                          child: Text(
                            '\u{20B9}',
                            style: TextStyle(fontSize: 9, color: Colors.black),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${snapshot.data!.data[0].totalCoins}'),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(height: 50, width: 150),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddCoins(widget.userid))).then((value) {
                          setState(() {
                            coinspagemodel =
                                CoinPageServices.getCoinPage(widget.userid);
                          });
                        });
                        //Navigator.pushNamed(context, AddCoins.id);
                      },
                      child: Text(
                        'Add coins',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ButtonStyle(
                        elevation: null,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.black))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF2596BE),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.orange[300],
                                radius: 7,
                                child: Text(
                                  '\u{20B9}',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.black),
                                )),
                            Text(
                              'Your Balance',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Text('${snapshot.data!.data[0].totalCoins}'),
                        SizedBox(width: 10),
                        // Text(
                        //   'Reedem Coins',
                        //   style: TextStyle(color: Color(0xFF2596BE)),
                        // ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          backgroundColor: Color(0xFF6A6A6C),
                                          title: Center(
                                              child:
                                                  Text('Enter Coins Amount')),
                                          content: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: coins_amountController,
                                            onChanged: (value) {
                                              value = coins_amountController
                                                  .text
                                                  .toString();
                                              //coins_amount = value;
                                            },
                                          ),
                                          actions: [
                                            Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    reedemCoins(
                                                            widget.userid,
                                                            coins_amountController
                                                                .text)
                                                        .then((value) {
                                                      setState(() {
                                                        coinspagemodel =
                                                            CoinPageServices
                                                                .getCoinPage(
                                                                    widget
                                                                        .userid);
                                                      });
                                                    });
                                                  });
                                                  Navigator.pop(context);
                                                  coins_amountController
                                                      .clear();
                                                },
                                                child: Text('Reedem'),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color(
                                                                0xFF2596BE))),
                                              ),
                                            ),
                                            //Text('Cancel')
                                          ],
                                        ));
                              });
                            },
                            child: Text(
                              'Reedem Coins',
                              style: TextStyle(
                                  color: Color(0xFF2596BE), fontSize: 14),
                            )),
                      ],
                    ),
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(height: 50, width: 400),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddCoins.id);
                      },
                      child: Text(
                        'Special Offers',
                        style:
                            TextStyle(color: Color(0xFF2596BE), fontSize: 18),
                      ),
                      style: ButtonStyle(
                        elevation: null,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.black))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Transaction(widget.userid)));
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Colors.white,
                                ),
                                Text('History',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                          height: 80,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.featured_play_list,
                                color: Colors.white,
                              ),
                              Text(
                                'Terms of Use',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        height: 80,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              Text('Share',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        height: 80,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40)
                ],
              );
            }),
      ),
    );
  }
}
