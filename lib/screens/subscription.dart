import 'dart:convert';
import 'package:find_friend/models/current_user_subscription_model.dart';
import 'package:find_friend/models/subscription_model.dart';
import 'package:find_friend/services/fetch_subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/add_subscription_plan.php';

class Subscription extends StatefulWidget {
  static String id = 'subscription';
  late String userid;
  Subscription(this.userid);

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  late Future<SubscriptionModel> subs;
  late Future<CurrentUserSubscriptionModel> currentSubs;
  late bool planOne = false;
  late bool planTwo = true;
  late bool planThird = false;

  Future addSubscriptionPlan(
      String userid, String planid, BuildContext context) async {
    var Response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': userid, 'plan_id': planid},
    );
    print('Add Subscription services called');
    print(Response.body);
    var response = jsonDecode(Response.body);
    if (!response['status']) {
      final snackbar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1000),
          backgroundColor: Colors.red,
          content: Text(response['message'], textAlign: TextAlign.center));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      final snackbar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1000),
          backgroundColor: Colors.red,
          content: Text('Plan Activated', textAlign: TextAlign.center));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void initState() {
    subs = SubscriptionPlanServices.getPlans();
    currentSubs = SubscriptionPlanServices.getCurrentUserPlan(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Subscription'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<CurrentUserSubscriptionModel>(
            future: currentSubs,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Current Plan :-',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFFFFFFFF).withOpacity(0.8)),
                      ),
                      (snapshot.data!.status)
                          ? Column(
                              children: [
                                Text(
                                  '${snapshot.data!.data[0].duration}       \u{20B9}${snapshot.data!.data[0].amount}',
                                  style: TextStyle(color: Color(0xFF6A6A6C)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                    '${snapshot.data!.data[0].totalChat} Chats',
                                    style: TextStyle(color: Color(0xFF6A6A6C))),
                              ],
                            )
                          : Text('${snapshot.data!.message}')
                    ],
                  ),
                  Text(
                    'Peak at who Liked you',
                    style: TextStyle(color: Color(0xFFFFFFFF).withOpacity(0.6)),
                  ),
                  FutureBuilder<SubscriptionModel>(
                      future: subs,
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 270,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: (planOne)
                                          ? Color(0xFF2596BE)
                                          : Color(0xFF6A6A6C))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 14, 0, 0),
                                    child: Container(
                                      height: 85,
                                      width: 92,
                                      child: Text(
                                        '${snapshot.data!.data[0].duration}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: (planOne)
                                                ? Color(0xFFFFFFFF)
                                                : Color(0xFF6A6A6C)),
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   'months',
                                  //   style: TextStyle(
                                  //       fontSize: 14, color: Color(0xFF6A6A6C)),
                                  // ),
                                  Divider(
                                    height: 1,
                                    color: (planOne)
                                        ? Color(0xFF2596BE)
                                        : Color(0xFF6A6A6C),
                                  ),
                                  Container(
                                    height: 25,
                                    child: Text(
                                      'SAVE 59%',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: (planOne)
                                              ? Color(0xFFFFFFFF)
                                              : Color(0xFF6A6A6C)),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: (planOne)
                                        ? Color(0xFF2596BE)
                                        : Color(0xFF6A6A6C),
                                  ),
                                  Text(
                                    '₹ ${snapshot.data!.data[0].amount}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: (planOne)
                                            ? Color(0xFFFFFFFF)
                                            : Color(0xFF6A6A6C)),
                                  ),
                                  Text(
                                    '${snapshot.data!.data[0].totalChat} Chats',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: (planOne)
                                            ? Color(0xFF2596BE)
                                            : Color(0xFF6A6A6C)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        planOne = true;
                                        planTwo = false;
                                        planThird = false;
                                        addSubscriptionPlan(
                                                widget.userid,
                                                '${snapshot.data!.data[0].planId}',
                                                context)
                                            .then((value) {
                                          setState(() {
                                            currentSubs =
                                                SubscriptionPlanServices
                                                    .getCurrentUserPlan(
                                                        widget.userid);
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: (planOne)
                                                ? Color(0xFF2596BE)
                                                : Color(0xFF6A6A6C),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            )),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'Buy Plan',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Container(
                                    height: 270,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                            color: (planTwo)
                                                ? Color(0xFF2596BE)
                                                : Color(0xFF6A6A6C))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 83,
                                            child: Text(
                                              '${snapshot.data!.data[1].duration}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: (planTwo)
                                                      ? Color(0xFFFFFFFF)
                                                      : Color(0xFF6A6A6C)),
                                            ),
                                          ),
                                          // Text(
                                          //   'months',
                                          //   style: TextStyle(
                                          //       fontSize: 14,
                                          //       color: Color(0xffFFFFFF)),
                                          // ),
                                          Divider(
                                            height: 1,
                                            color: (planTwo)
                                                ? Color(0xFF2596BE)
                                                : Color(0xFF6A6A6C),
                                          ),
                                          Container(
                                            height: 22,
                                            child: Center(
                                              child: Text(
                                                'SAVE 59%',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: (planTwo)
                                                        ? Color(0xFFFFFFFF)
                                                        : Color(0xFF6A6A6C)),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            height: 1,
                                            color: (planTwo)
                                                ? Color(0xFF2596BE)
                                                : Color(0xFF6A6A6C),
                                          ),
                                          Text(
                                            '₹ ${snapshot.data!.data[1].amount}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: (planTwo)
                                                    ? Color(0xFFFFFFFF)
                                                    : Color(0xFF6A6A6C)),
                                          ),
                                          Text(
                                            '${snapshot.data!.data[1].totalChat} Chats',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: (planTwo)
                                                    ? Color(0xFF2596BE)
                                                    : Color(0xFF6A6A6C)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                planOne = false;
                                                planTwo = true;
                                                planThird = false;
                                                addSubscriptionPlan(
                                                        widget.userid,
                                                        '${snapshot.data!.data[1].planId}',
                                                        context)
                                                    .then((value) {
                                                  setState(() {
                                                    currentSubs =
                                                        SubscriptionPlanServices
                                                            .getCurrentUserPlan(
                                                                widget.userid);
                                                  });
                                                });
                                              });
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: (planTwo)
                                                      ? Color(0xFF2596BE)
                                                      : Color(0xFF6A6A6C),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6),
                                                  )),
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Buy Now',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 2,
                                  left: 29,
                                  child: Container(
                                    width: 63,
                                    height: 23,
                                    decoration: BoxDecoration(
                                        color: (planTwo)
                                            ? Color(0xFF2596BE)
                                            : Color(0xFF6A6A6C),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        'Most Popular',
                                        style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                  ))
                            ]),
                            Container(
                              height: 270,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: (planThird)
                                          ? Color(0xFF2596BE)
                                          : Color(0xFF6A6A6C))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 14, 0, 0),
                                    child: Container(
                                      height: 85,
                                      width: 92,
                                      child: Text(
                                        '${snapshot.data!.data[2].duration}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: (planThird)
                                                ? Color(0xFFFFFFFF)
                                                : Color(0xFF6A6A6C)),
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   'months',
                                  //   style: TextStyle(
                                  //       fontSize: 14, color: Color(0xFF6A6A6C)),
                                  // ),
                                  Divider(
                                    height: 1,
                                    color: (planThird)
                                        ? Color(0xFF2596BE)
                                        : Color(0xFF6A6A6C),
                                  ),
                                  Container(
                                    height: 25,
                                    child: Text(
                                      'SAVE 59%',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: (planThird)
                                              ? Color(0xFFFFFFFF)
                                              : Color(0xFF6A6A6C)),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: (planThird)
                                        ? Color(0xFF2596BE)
                                        : Color(0xFF6A6A6C),
                                  ),
                                  Text(
                                    '₹ ${snapshot.data!.data[2].amount}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: (planThird)
                                            ? Color(0xFFFFFFFF)
                                            : Color(0xFF6A6A6C)),
                                  ),
                                  Text(
                                    '${snapshot.data!.data[2].totalChat} Chats',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: (planThird)
                                            ? Color(0xFF2596BE)
                                            : Color(0xFF6A6A6C)),
                                  ),
                                  // Divider(
                                  //   height: 1,
                                  //   color: Colors.grey,
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        planOne = false;
                                        planTwo = false;
                                        planThird = true;
                                        addSubscriptionPlan(
                                                widget.userid,
                                                '${snapshot.data!.data[2].planId}',
                                                context)
                                            .then((value) {
                                          setState(() {
                                            currentSubs =
                                                SubscriptionPlanServices
                                                    .getCurrentUserPlan(
                                                        widget.userid);
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: (planThird)
                                              ? Color(0xFF2596BE)
                                              : Color(0xFF6A6A6C),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6),
                                          )),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          'Buy Plan',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                  (snapshot.data!.status)
                      ? Text(
                          '${snapshot.data!.data[0].planExpire} !!!',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF).withOpacity(0.8),
                              fontWeight: FontWeight.w900),
                        )
                      : Text(''),
                ],
              );
            }),
      ),
    );
  }
}
