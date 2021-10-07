import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:flutter/material.dart';
import 'constant_chat.dart';

class Convo extends StatefulWidget {
  String chatRoomId;
  String otherUsername;
  String profileUrl;
  Convo(this.chatRoomId, this.otherUsername, this.profileUrl);

  @override
  _ConvoState createState() => _ConvoState();
}

class _ConvoState extends State<Convo> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController _controller = TextEditingController();
  late Stream chatMessageStream;

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

  @override
  void initState() {
    databaseMethods.getConversationMessage(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      appBar: AppBar(
        title: Text(widget.otherUsername),
        leadingWidth: 42,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(1.0),
          child: CircleAvatar(backgroundImage: NetworkImage(widget.profileUrl)),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: ChatMessageList()),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.grey,
                          //height: 30,
                          child: TextField(
                            controller: _controller,
                          ))),
                  SizedBox(width: 15),
                  GestureDetector(
                    child: Icon(Icons.send, color: Colors.white),
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isSendByMe ? Colors.blue : Colors.grey,
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
            padding: const EdgeInsets.all(9.0),
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
