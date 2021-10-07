import 'package:find_friend/screens/calling_pages/incoming_call.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  late FirebaseMessaging _firebaseMessaging;

  void setupFirebase(BuildContext context) {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getInitialMessage().then((value) {
      if (value != null) {
        String channel_name = value.data['channel_name'];
        print(channel_name + 'inside videocalllllllllllllllllllllll');
        String screenId = value.data['screenId'];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IncomingCallScreen(
                      channel_name: value.data['channel_name'],
                      Screen_id: value.data['screenId'],
                    )));
      }
    });
    notificationhandler(context);
  }

  void notificationhandler(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      String channel_name = event.data['channel_name'];
      print(channel_name + 'inside videocall');
      String screenId = event.data['screenId'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IncomingCallScreen(
                    channel_name: event.data['channel_name'],
                    Screen_id: event.data['screenId'],
                  )));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      String channel_name = event.data['channel_name'];
      print(channel_name + 'inside videocalllll');
      String screenId = event.data['screenId'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IncomingCallScreen(
                    channel_name: event.data['channel_name'],
                    Screen_id: event.data['screenId'],
                  )));
    });
  }
}
