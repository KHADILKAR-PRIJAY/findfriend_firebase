import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/screens/demo_screen/chat_room.dart';
import 'package:find_friend/screens/demo_screen/search_page.dart';
import 'package:flutter/material.dart';

import 'constant_chat.dart';

class Demop extends StatefulWidget {
  @override
  _DemopState createState() => _DemopState();
}

class _DemopState extends State<Demop> {
  TextEditingController _usernamecontroller = TextEditingController();

  TextEditingController _idcontroller = TextEditingController();

  signme() {
    setState(() {
      Map<String, String> userInfoMap = {
        'name': _usernamecontroller.text,
        'id': _idcontroller.text,
        'profile':
            'https://crush.notionprojects.tech/upload/profile/1628845336_DESK.jpg'
      };
      DatabaseMethods databaseMethods =
          new DatabaseMethods().uploadUserInfo(userInfoMap, _idcontroller.text);

      //DatabaseMethods().uploadUserInfoCustom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign up'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('username'),
            TextField(
              controller: _usernamecontroller,
            ),
            SizedBox(height: 25),
            Text('id'),
            TextField(controller: _idcontroller),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                signme();
              },
              child: Container(
                height: 30,
                width: 150,
                color: Colors.blue,
                child: Center(child: Text('sign up')),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPAGE()));
              },
              child: Container(
                height: 30,
                width: 150,
                color: Colors.orange,
                child: Center(child: Text('Go to Search Page')),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatRoom()));
              },
              child: Container(
                height: 30,
                width: 150,
                color: Colors.pinkAccent,
                child: Center(child: Text('Go to Chat lobby')),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                DatabaseMethods databaseMethods = new DatabaseMethods();
                databaseMethods.getChatRooms(ConstantChat.myName).then((value) {
                  setState(() async {
                    await FirebaseFirestore.instance
                        .collection(((value as QuerySnapshot<Object?>))
                            .docs[0]
                            .get('chatRoomid'))
                        .doc()
                        .update({
                      'users': ['', '1']
                    });
                  });
                });
              },
              child: Container(
                height: 30,
                width: 150,
                color: Colors.green,
                child: Center(child: Text('UpDATE')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
