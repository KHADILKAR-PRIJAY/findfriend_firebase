import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/screens/Chat_pages/conversation_screen.dart';
import 'package:find_friend/screens/demo_screen/constant_chat.dart';
import 'package:find_friend/screens/search_page.dart';
import 'package:find_friend/timeStamp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'database.dart';

const String url = 'http://findfriend.notionprojects.tech/api/friends.php';
bool thi = false;

class Chats extends StatefulWidget {
  String userid;
  Chats(this.userid);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.black,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF6A6A6C),
                    radius: 19,
                    child: CircleAvatar(
                        radius: 19,
                        backgroundImage: AssetImage('assets/images/girl.jpg')),
                  ),
                  SizedBox(width: 40),
                  Text(
                    (selectedIndex == 1) ? 'Chats' : 'Friends',
                    style: TextStyle(fontSize: 22),
                  )
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.more_horiz),
                )
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 45),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SearchPage.id);
                },
                child: TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xFFF0EEEF)),
                      fillColor: Color(0xFF6A6A6C),
                      prefixIcon: Icon(Icons.search, color: Color(0xFFF0EEEF)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 10),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.solidComment,
                              color: (selectedIndex == 1)
                                  ? Color(0xFF2596BE)
                                  : Colors.grey),
                          onPressed: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                        ),
                        Text('Chats',
                            style: TextStyle(
                                color: (selectedIndex == 1)
                                    ? Color(0xFF2596BE)
                                    : Colors.grey))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.people,
                              color: (selectedIndex == 2)
                                  ? Color(0xFF2596BE)
                                  : Colors.grey),
                          onPressed: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                        ),
                        Text(
                          'Friends',
                          style: TextStyle(
                              color: (selectedIndex == 2)
                                  ? Color(0xFF2596BE)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (selectedIndex == 1)
                ? Expanded(child: ChatView())
                : FriendsView(widget.userid)
          ],
        ),
      ),
    );
  }
}

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  late Stream chatRoomsStream;

  Widget ChatRoomList(BuildContext context) {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          return ListView.builder(
              shrinkWrap: true,
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
      backgroundColor: Colors.black,
      body: ChatRoomList(context),
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
  var time = TimestampFormat();

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Conversation_Page(
              widget.chatRoomId,
              searchSnapshot.docs[0].get('name'),
              searchSnapshot.docs[0].get('profile'),
              searchSnapshot.docs[0].get('id'),
            ),
          ),
        );
      },
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff1E1E1E),
              radius: 26,
              child: CircleAvatar(
                  radius: 24,
                  backgroundImage:
                      NetworkImage(searchSnapshot.docs[0].get('profile'))),
            ),
            (searchSnapshot.docs[0].get('status') == 'online')
                ? Positioned(
                    top: 0,
                    left: 34,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF1FDEB3),
                      radius: 4,
                    ))
                : Positioned(
                    top: 0,
                    left: 34,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 4,
                    ),
                  )
          ],
        ),
        title: Text(searchSnapshot.docs[0].get('name')),
        subtitle: (searchSnapshot.docs[0].get('status').toString() == 'offline')
            ? Text(
                time.parseTime(DateTime.parse(
                        searchSnapshot.docs[0].get('timeStamp'))) ??
                    "",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            : Text('active now'),
      ),
    );
  }
}

class FriendsView extends StatefulWidget {
  late String userid;
  FriendsView(this.userid);
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  Future getFriendsList() async {
    var response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'user_id': widget.userid},
    );
    print(response.body);
    setState(() {
      fm = jsonDecode(response.body)['data'];
    });
    // if (response.statusCode == 200) {
    //   thi = true;
    // }
    return response.body;
  }

  List fm = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriendsList();
    print("chat called");
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   postFriends();
    //   postFriends().then((data) => fm = jsonDecode(data)['data']);
    // });

    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: fm.length,
          itemBuilder: (context, index) {
            return (fm.length == 0)
                ? Container(
                    color: Colors.white,
                    height: 60,
                    width: 60,
                  )
                : ListTile(
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF6A6A6C),
                          radius: 19,
                          child: CircleAvatar(
                              radius: 19,
                              backgroundImage: NetworkImage(
                                  fm[index]['profile_image'].toString())),
                        ),
                        Positioned(
                          top: 0,
                          left: 28,
                          child: (index == 1 || index == 4)
                              ? CircleAvatar(
                                  backgroundColor: Color(0xFF1FDEB3),
                                  radius: 4,
                                )
                              : Container(),
                        )
                      ],
                    ),
                    title: Text(fm[index]['full_name'].toString()),
                    subtitle: (index == 1 || index == 4)
                        ? Text('Active now',
                            style: TextStyle(color: Colors.grey))
                        : Text('Active 15m ago',
                            style: TextStyle(color: Colors.grey)),
                    // trailing: (index == 1 || index == 5)
                    //     ? FollowButton()
                    //     : FollowingButton()
                  );
          }),
    );
  }
}

class FollowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 25, width: 75),
      child: ElevatedButton(
        onPressed: null,
        child: Text(
          'Follow',
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
        ),
        style: ButtonStyle(
          elevation: null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Colors.black))),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xFF2596BE),
          ),
        ),
      ),
    );
  }
}

class FollowingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: 25,
        width: 75,
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Following',
          style: TextStyle(
              color: Color(0xff707070),
              fontSize: 9,
              fontWeight: FontWeight.w900),
        ),
        style: ButtonStyle(
          elevation: null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Color(0xff707070)))),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
