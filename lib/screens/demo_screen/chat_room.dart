import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/screens/demo_screen/constant_chat.dart';
import 'package:find_friend/screens/demo_screen/convo_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  late Stream chatRoomsStream;

  Widget ChatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (context, index) {
                return ChatRoomTile(
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('chatRoomid')
                        .toString()
                        .replaceAll('_', '')
                        .replaceAll(ConstantChat.myId, ''),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('chatRoomid'));
              });
        });
  }

  @override
  void initState() {
    databaseMethods.getChatRooms(ConstantChat.myId).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.withOpacity(0.2),
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: Colors.pinkAccent.withOpacity(0.8),
        centerTitle: true,
      ),
      body: ChatRoomList(),
    );
  }
}

class ChatRoomTile extends StatefulWidget {
  String userId;
  String chatRoomId;

  ChatRoomTile(this.userId, this.chatRoomId);

  @override
  _ChatRoomTileState createState() => _ChatRoomTileState();
}

class _ChatRoomTileState extends State<ChatRoomTile> {
  late QuerySnapshot searchSnapshot;
  DatabaseMethods databasemethods = DatabaseMethods();
  @override
  void initState() {
    databasemethods.getUser(widget.userId).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Convo(
                      widget.chatRoomId,
                      searchSnapshot.docs[0].get('name'),
                      searchSnapshot.docs[0].get('profile'))));
        },
        child: Container(
          color: Colors.pinkAccent.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundImage:
                        NetworkImage(searchSnapshot.docs[0].get('profile'))),
                SizedBox(width: 10),
                Text(searchSnapshot.docs[0].get('name'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
