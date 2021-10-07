import 'package:find_friend/screens/calling_pages/video_call.dart';
import 'package:find_friend/screens/calling_pages/voice_call.dart';
import "package:flutter/material.dart";

class IncomingCallScreen extends StatefulWidget {
  final String channel_name;
  final String Screen_id;
  const IncomingCallScreen(
      {Key? key, required this.channel_name, required this.Screen_id})
      : super(key: key);

  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
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
                  Navigator.pop(context);
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
                                  // user_id: widget.user_id,
                                  channelName: widget.channel_name)))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoiceCallPg(
                                  // user_id: widget.user_id,
                                  channelName: widget.channel_name)));
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
