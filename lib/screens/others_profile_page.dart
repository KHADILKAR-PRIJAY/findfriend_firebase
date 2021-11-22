import 'dart:convert';
import 'package:find_friend/firebase_notification_handler/notification_handler.dart';
import 'package:find_friend/firebase_notification_handler/send_notofication.dart';
import 'package:find_friend/models/getpost_model.dart';
import 'package:find_friend/models/others_profile.dart';
import 'package:find_friend/services/check_call_rates.dart';
import 'package:find_friend/services/fetch_post.dart';
import 'package:find_friend/services/fetch_profile.dart';
import 'package:find_friend/services/fetch_subscription.dart';
import 'package:find_friend/services/generate_channel_name.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'Chat_pages/conversation_screen.dart';
import 'Chat_pages/database.dart';
import 'calling_pages/video_call.dart';
import 'calling_pages/voice_call.dart';
import 'demo_screen/constant_chat.dart';

const String url =
    'http://findfriend.notionprojects.tech/api/add_following_users.php';
const String urll =
    'http://findfriend.notionprojects.tech/api/check_follow_button.php';

class OthersProfilePage extends StatefulWidget {
  static String id = 'others_profile';
  late String username;
  String userid;
  String othersid;
  String otherUser_FCMtoken;
  String UserTotalCoin;
  OthersProfilePage(
      {required this.userid,
      required this.username,
      required this.othersid,
      required this.otherUser_FCMtoken,
      required this.UserTotalCoin});

  @override
  _OthersProfilePageState createState() => _OthersProfilePageState();
}

class _OthersProfilePageState extends State<OthersProfilePage> {
  late Future<OthersProfile> pf;
  late Future<GetPostModel> getpostmodel;
  late String check;
  late bool statusCheck;
  late String cn;
  late String audioCallRate;
  late String videoCallRate;
  late String UserSubscriptionPlanStatus;

  getCallRates() {
    CallRateServices().getAudiorate().then((value) {
      audioCallRate = value['data']['audio_call_rate'];
      print('Audio call rates:   ' + audioCallRate);
    });
    CallRateServices().getVideorate().then((value) {
      videoCallRate = value['data']['video_call_rate'];
      print('Video call rates:   ' + videoCallRate);
    });
  }

  createChatRoomAndStartConversation(
      String otherId, String username, String profile) {
    String chatRoomId = getChatRoomId(otherId, ConstantChat.myId);
    List<String> users = [ConstantChat.myId, otherId];
    Map<String, dynamic> chatRoomMap = {
      'users': users,
      'chatRoomid': chatRoomId,
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Conversation_Page(chatRoomId, username, profile, otherId)));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return '$b\_$a';
    } else {
      return '$a\_$b';
    }
  }

  Future addFollowingServices(
      {required String userid, required String followedid}) async {
    var res = await http.post(
      Uri.parse(url),
      body: {
        'token': '123456789',
        'follower_id': userid,
        'followed_user_id': followedid
      },
    );
    print('Add following services called: \n');
    print(res.body);
    if (res.statusCode == 200) {
      print('Followed succesfully');
    }
  }

  Future checkFollowButton(
      {required String userid, required String followedid}) async {
    var Response = await http.post(
      Uri.parse(urll),
      body: {
        'token': '123456789',
        'user_id': userid,
        'followed_user_id': followedid
      },
    );
    print(' check follow button services called: \n');
    print('Userid: ' + userid);
    print('Others_Profile id: ' + followedid);
    print(Response.body);
    var response = jsonDecode(Response.body);
    print('status----------------------' + response['status'].toString());
    setState(() {
      if (response['status']) {
        check = response['data']['request_confirm'];
        statusCheck = response['status'];
        print(statusCheck.toString());
      } else {
        statusCheck = response['status'];
        print('Nai huaaaaa');
      }
    });
  }

  @override
  void initState() {
    getCallRates();
    pf = ProfileServices.getOthersProfileTwo(widget.username);
    getpostmodel = PostServices.getPost(widget.othersid);
    checkFollowButton(userid: widget.userid, followedid: widget.othersid);
    SubscriptionPlanServices.getCurrentUserPlan(widget.userid).then((value) {
      UserSubscriptionPlanStatus = value.message;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<OthersProfile>(
          future: pf,
          builder: (context, snapshot) {
            return Column(
              children: [
                AppBar(
                  backgroundColor: Colors.black,
                  title: Text('${snapshot.data!.data[0].username}'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.more_horiz),
                    )
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xFFD01B65),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 38,
                                child: CircleAvatar(
                                    radius: 36,
                                    backgroundImage: NetworkImage(
                                        '${snapshot.data!.data[0].profilePicture}')),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('10'),
                                        ),
                                        Text('Posts'),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('61'),
                                          ),
                                          Text('Followers'),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('56'),
                                          ),
                                          Text('Following'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Text(
                              'About Us',
                              style: TextStyle(color: Color(0xff2596BE)),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              (statusCheck)
                                  ? (check == 'n')
                                      ?
                                      // Follow Button -----------------------------------------------------------------------------------------------------
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    height: 25, width: 85),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  addFollowingServices(
                                                          userid: widget.userid,
                                                          followedid:
                                                              widget.othersid)
                                                      .then((value) {
                                                    setState(() {
                                                      pf = ProfileServices
                                                          .getOthersProfileTwo(
                                                              widget.username);
                                                    });
                                                  });

                                                  print('userid:${widget.userid}' +
                                                      'followed ${widget.othersid}');
                                                });
                                              },
                                              child: Text(
                                                'Follow',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              style: ButtonStyle(
                                                  elevation: null,
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .black))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Color(0xFF2596BE),
                                                  )),
                                            ),
                                          ),
                                        )
                                      :
                                      //following Button---------------------------------------------------------------------------------------------
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    height: 25, width: 85),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Following',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )

                                  // Follow Button------------------------------------------------------------------------------------------------------
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            height: 25, width: 85),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              addFollowingServices(
                                                      userid: widget.userid,
                                                      followedid:
                                                          widget.othersid)
                                                  .then((value) {
                                                setState(() {
                                                  pf = ProfileServices
                                                      .getOthersProfileTwo(
                                                          widget.username);
                                                });
                                              });

                                              print('userid:${widget.userid}' +
                                                  'followed ${widget.othersid}');
                                            });
                                          },
                                          child: Text(
                                            'Follow',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          style: ButtonStyle(
                                              elevation: null,
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                      side: BorderSide(
                                                          color:
                                                              Colors.black))),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Color(0xFF2596BE),
                                              )),
                                        ),
                                      ),
                                    ),
                              Container(height: 20),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${snapshot.data!.data[0].bio}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                Colors.white.withOpacity(0.6)),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      (statusCheck)
                          ? (check == 'n')
                              ? Container(
                                  width: 100,
                                  color: Colors.purple,
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.video_call),
                                          color: Colors.white,
                                          onPressed: () {
                                            ///////////////////////////////////////////
                                            if (double.parse(
                                                    widget.UserTotalCoin
                                                        .toString()) >=
                                                double.parse(
                                                    videoCallRate.toString())) {
                                              generatechannel()
                                                  .GenerateChannel()
                                                  .then(
                                                (value) {
                                                  setState(
                                                    () {
                                                      cn = value;
                                                      print(cn.toString() +
                                                          '////////////');
                                                      sendnotification(
                                                          cn,
                                                          widget
                                                              .otherUser_FCMtoken,
                                                          '0',
                                                          widget.userid,
                                                          '${snapshot.data!.data[0].userId}',
                                                          '');
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoCallPage(
                                                                    //user_id: widget.user_id,
                                                                    channelName:
                                                                        cn,
                                                                    caller_id:
                                                                        '${snapshot.data!.data[0].userId}',
                                                                    CallerImage:
                                                                        '${snapshot.data!.data[0].profilePicture}',
                                                                    callStatus:
                                                                        'o',
                                                                    user_id: widget
                                                                        .userid,
                                                                  ))).then(
                                                          (value) {
                                                        Rejcted = false;
                                                      });
                                                    },
                                                  );
                                                },
                                              );
                                            } else {
                                              final snackbar = SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  duration: Duration(
                                                      milliseconds: 1000),
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'Not enough Coins',
                                                      textAlign:
                                                          TextAlign.center));
                                            }
                                          },
                                        ),
                                        Text('Video Call',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.phone),
                                          color: Colors.white,
                                          onPressed: () {
                                            ///////////////////////////////////////////
                                            if (double.parse(
                                                    widget.UserTotalCoin
                                                        .toString()) >=
                                                double.parse(
                                                    audioCallRate.toString())) {
                                              generatechannel()
                                                  .GenerateChannel()
                                                  .then(
                                                (value) {
                                                  setState(
                                                    () {
                                                      cn = value;
                                                      print(cn.toString() +
                                                          '////////////');
                                                      sendnotification(
                                                          cn,
                                                          widget
                                                              .otherUser_FCMtoken,
                                                          '1',
                                                          widget.userid,
                                                          '${snapshot.data!.data[0].userId}',
                                                          '');
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      VoiceCallPg(
                                                                        //user_id: widget.user_id,
                                                                        channelName:
                                                                            cn,
                                                                        user_id:
                                                                            widget.userid,
                                                                        callStatus:
                                                                            'o',
                                                                        CallerImage:
                                                                            '${snapshot.data!.data[0].profilePicture}',
                                                                        caller_id:
                                                                            '${snapshot.data!.data[0].userId}',
                                                                      ))).then(
                                                          (value) {
                                                        Rejcted = false;
                                                      });
                                                    },
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                        Text('Call',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                              FontAwesomeIcons
                                                  .facebookMessenger,
                                              color: Colors.white,
                                              size: 22),
                                          onPressed: () {
                                            if (UserSubscriptionPlanStatus ==
                                                'success') {
                                              createChatRoomAndStartConversation(
                                                  '${snapshot.data!.data[0].userId}',
                                                  '${snapshot.data!.data[0].username}',
                                                  '${snapshot.data!.data[0].profilePicture}');
                                            } else {
                                              final snackbar = SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  duration: Duration(
                                                      milliseconds: 1000),
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'No plan activated',
                                                      textAlign:
                                                          TextAlign.center));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackbar);
                                            }
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Message',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14)),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                          : Container(
                              width: 100,
                              color: Colors.purple,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Username:-\n'
                                  'Age :-\n'
                                  'Gender :-\n'
                                  'City :-\n',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                    '   ${snapshot.data!.data[0].username}\n'
                                    '   ${snapshot.data!.data[0].age}\n'
                                    '   ${snapshot.data!.data[0].gender}\n'
                                    '   ${snapshot.data!.data[0].city}\n',
                                    style: TextStyle(fontSize: 13))
                              ],
                            ),
                            Container(
                              height: 90,
                              child: VerticalDivider(
                                thickness: 1,
                                color: Color(0xFFF6F4F4),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                    'Qualification:-\n'
                                    'Height :-\n'
                                    'Status :-\n'
                                    'DOB :-\n',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6)))
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                    '${snapshot.data!.data[0].qualification}\n'
                                    '${snapshot.data!.data[0].height}\n'
                                    '${snapshot.data!.data[0].maritalStatus}\n'
                                    '${snapshot.data!.data[0].birthday}\n',
                                    style: TextStyle(fontSize: 13))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              //backgroundImage: AssetImage('assets/images/instabg.jpg'),
                              backgroundColor: Color(0xff6A6A6C),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 27,
                                    child:
                                        Icon(FontAwesomeIcons.instagramSquare)),
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff6A6A6C),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                    radius: 27,
                                    child: Icon(FontAwesomeIcons.twitter)),
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff6A6A6C),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 27,
                                    child: Icon(FontAwesomeIcons.youtube)),
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff6A6A6C),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 27,
                                  child: Icon(FontAwesomeIcons.facebookF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<GetPostModel>(
                          future: getpostmodel,
                          builder: (BuildContext context, snapshot) {
                            return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: snapshot.data!.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      child: Image.network(
                                          '${snapshot.data!.data[index].post}',
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                });
                          })
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
// ('${snapshot.data!.data[0].isConfirm}' == 'y' &&
// '${snapshot.data!.data[0].requestSent}' ==
// 'y')
// ?
// // following
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ConstrainedBox(
// constraints: BoxConstraints.tightFor(
// height: 25, width: 85),
// child: Container(
// decoration: BoxDecoration(
// border:
// Border.all(color: Colors.white),
// borderRadius: BorderRadius.all(
// Radius.circular(4)),
// ),
// child: Center(
// child: Text(
// 'Following',
// style: TextStyle(
// color: Colors.white,
// fontSize: 10,
// fontWeight: FontWeight.w900),
// ),
// ),
// ),
// ),
// )
// : ('${snapshot.data!.data[0].isConfirm}' ==
// 'n' &&
// '${snapshot.data!.data[0].requestSent}' ==
// 'n')
// ?
// // follow
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ConstrainedBox(
// constraints:
// BoxConstraints.tightFor(
// height: 25, width: 85),
// child: ElevatedButton(
// onPressed: () {
// setState(() {
// addFollowingServices(
// userid: widget.userid,
// followedid:
// widget.othersid)
//     .then((value) {
// setState(() {
// pf = ProfileServices
//     .getOthersProfileTwo(
// widget.username);
// });
// });
//
// print('userid:${widget.userid}' +
// 'followed ${widget.othersid}');
// });
// },
// child: Text(
// 'Follow',
// style: TextStyle(
// color: Colors.white,
// fontSize: 10,
// fontWeight:
// FontWeight.w900),
// ),
// style: ButtonStyle(
// elevation: null,
// shape: MaterialStateProperty
//     .all<RoundedRectangleBorder>(
// RoundedRectangleBorder(
// borderRadius:
// BorderRadius
//     .circular(
// 4.0),
// side: BorderSide(
// color: Colors
//     .black))),
// backgroundColor:
// MaterialStateProperty.all<
//     Color>(
// Color(0xFF2596BE),
// )),
// ),
// ),
// )
// :
// //requested
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ConstrainedBox(
// constraints:
// BoxConstraints.tightFor(
// height: 25, width: 85),
// child: Container(
// decoration: BoxDecoration(
// border: Border.all(
// color: Colors.white),
// borderRadius: BorderRadius.all(
// Radius.circular(4)),
// ),
// child: Center(
// child: Text(
// 'Requested',
// style: TextStyle(
// color: Colors.white,
// fontSize: 10,
// fontWeight:
// FontWeight.w900),
// ),
// ),
// ),
// ),
// ),
