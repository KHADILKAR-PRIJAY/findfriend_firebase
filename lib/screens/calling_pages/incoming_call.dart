import 'dart:convert';

import 'package:find_friend/firebase_notification_handler/send_notofication.dart';
import 'package:find_friend/screens/calling_pages/video_call.dart';
import 'package:find_friend/screens/calling_pages/voice_call.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/get_userFcm.php';

class IncomingCallScreen extends StatefulWidget {
  final String channel_name;
  final String Screen_id;
  final String caller_id;
  final String user_id;
  final String user_Image;
  const IncomingCallScreen(
      {Key? key,
      required this.channel_name,
      required this.Screen_id,
      required this.caller_id,
      required this.user_id,
      required this.user_Image})
      : super(key: key);

  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  late String FCMtoken;

  Future getOtherUserFCMtoken(String otherUserId) async {
    var Response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': otherUserId},
    );
    print('get OtherUser FCM services called');
    print(Response.body);
    var response = jsonDecode(Response.body);
    FCMtoken = response['data']['fcm_token'];
  }

  //late Future<HomeUserProfile> user;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.caller_id + 'llllllllllllll');
    getOtherUserFCMtoken(widget.caller_id);
    // user = HomeUserProfileService()
    //     .gethomeProfile(
    //         user_id: widget.caller_id, login_userID: widget.caller_id)
    //     .then((value) {
    //   setState(() {
    //     fcm_token = value.data.fcm_token;
    //     print(fcm_token + 'yyyyyyyyyyyyyyyyyy');
    //   });
    //   return value;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incoming VideoCall'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  rejectCall(FCMtoken).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: Text('Reject'),
                color: Colors.red,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  (widget.Screen_id == '0')
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoCallPage(
                                  CallerImage: widget.user_Image,
                                  caller_id: widget.caller_id,
                                  callStatus: 'i',
                                  user_id: widget.user_id,
                                  channelName: widget.channel_name)))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoiceCallPg(
                                    caller_id: widget.caller_id,
                                    callStatus: 'i',
                                    user_id: widget.user_id,
                                    channelName: widget.channel_name,
                                    CallerImage: widget.user_Image,
                                  )));
                },
                color: Colors.green,
                child: Text('Accept'),
              )
            ],
          )
        ],
      ),
    );
  }
}
