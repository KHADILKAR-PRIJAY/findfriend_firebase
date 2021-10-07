import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/screens/demo_screen/convo_page.dart';
import 'package:flutter/material.dart';
import 'constant_chat.dart';

class SearchPAGE extends StatefulWidget {
  @override
  _SearchPAGEState createState() => _SearchPAGEState();
}

class _SearchPAGEState extends State<SearchPAGE> {
  TextEditingController _name = TextEditingController();
  DatabaseMethods databasemethods = DatabaseMethods();
  late QuerySnapshot searchSnapshot;

  initiateSearch() {
    databasemethods.getUser(_name.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.docs.length,
            itemBuilder: (context, index) {
              return SearchTile(
                  searchSnapshot.docs[0].get('name'),
                  searchSnapshot.docs[0].get('profile'),
                  searchSnapshot.docs[0].get('id'));
            })
        : Text('null');
  }

  createChatRoomAndStartConversation(String otherId) {
    String chatRoomId = getChatRoomId(otherId, ConstantChat.myId);
    List<String> users = [ConstantChat.myId, otherId];
    //List<String> profileImage = [ConstantChat.myimage, src];
    Map<String, dynamic> chatRoomMap = {
      'users': users,
      //'profileimgs': profileImage,
      'chatRoomid': chatRoomId,
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Convo(chatRoomId, '', '')));
  }

  Widget SearchTile(String name, String src, String id) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(src),
            ),
            Text('Name :  ${name}'),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                createChatRoomAndStartConversation(id);
              },
              child: Container(
                  height: 30,
                  width: 90,
                  color: Colors.blue,
                  child: Center(child: Text('Message'))),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black,
                  width: 250,
                  child: TextField(
                    controller: _name,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      initiateSearch();
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 50,
                    ))
              ],
            ),
            SizedBox(height: 30),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //       height: 30,
            //       width: 90,
            //       color: Colors.blue,
            //       child: Center(child: Text('chat page'))),
            // ),
            // SizedBox(height: 20),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}
