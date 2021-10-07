import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/firebase_notification_handler/send_notofication.dart';
import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/screens/calling_pages/video_call.dart';
import 'package:find_friend/screens/calling_pages/voice_call.dart';
import 'package:find_friend/screens/demo_screen/constant_chat.dart';
import 'package:find_friend/services/generate_channel_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/get_userFcm.php';

class Conversation_Page extends StatefulWidget {
  String chatRoomId;
  String profileimage;
  String otherUsername;
  String otherUserId;
  Conversation_Page(
      this.chatRoomId, this.otherUsername, this.profileimage, this.otherUserId);

  @override
  _Conversation_PageState createState() => _Conversation_PageState();
}

class _Conversation_PageState extends State<Conversation_Page> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController _controller = TextEditingController();
  late Stream chatMessageStream;
  late String cn;
  late String FCMtoken;

  Widget ChatMessageList() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: StreamBuilder(
          stream: chatMessageStream,
          builder: (builder, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                    itemBuilder: (context, index) {
                      return MessageTile(
                          (snapshot.data! as QuerySnapshot).docs[index]
                              ["message"],
                          (snapshot.data! as QuerySnapshot).docs[index]
                                  ["send by"] ==
                              ConstantChat.myName);
                    })
                : Container();
          }),
    );
  }

  sendMessage() {
    if (_controller.text.isNotEmpty) {
      Map<String, String> messageMap = {
        'message': _controller.text,
        'send by': ConstantChat.myName,
        'time': DateTime.now().microsecondsSinceEpoch.toString(),
      };
      databaseMethods.addConversationMessage(widget.chatRoomId, messageMap);
      _controller.clear();
    }
  }

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

  @override
  void initState() {
    databaseMethods.getConversationMessage(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    }).then((value) {
      getOtherUserFCMtoken(widget.otherUserId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 25,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF6A6A6C),
              radius: 19,
              child: CircleAvatar(
                  radius: 19,
                  backgroundImage: NetworkImage(widget.profileimage)),
            ),
            //SizedBox(width: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.otherUsername,
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.phone),
              color: Colors.white,
              onPressed: () {
                ///////////////////////////////////////////
                generatechannel().GenerateChannel().then(
                  (value) {
                    setState(
                      () {
                        cn = value;
                        print(cn.toString() + '////////////');
                        sendnotification(cn, FCMtoken, '1');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VoiceCallPg(
                                      //user_id: widget.user_id,
                                      channelName: cn,
                                    )));
                      },
                    );
                  },
                );
              }),
          IconButton(
              icon: Icon(Icons.video_call),
              color: Colors.white,
              onPressed: () {
                ///////////////////////////////////////////
                generatechannel().GenerateChannel().then(
                  (value) {
                    setState(
                      () {
                        cn = value;
                        print(cn.toString() + '////////////');
                        sendnotification(cn, FCMtoken, '0');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoCallPage(
                                      //user_id: widget.user_id,
                                      channelName: cn,
                                    )));
                      },
                    );
                  },
                );
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: Color(0xff1FDEB3),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessageList()),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          color: Color(0xff1E1E1E),
                          //height: 30,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Write message here.....',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            controller: _controller,
                          ))),
                  Container(color: Colors.grey, height: 48, width: 1.5),
                  GestureDetector(
                    child: Container(
                        height: 48,
                        width: 50,
                        color: Color(0xff1E1E1E),
                        child: Icon(Icons.send, color: Colors.white)),
                    onTap: () {
                      sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  String message;
  bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isSendByMe ? Color(0xff2596BE) : Color(0xff6A6A6C),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))
                : BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
