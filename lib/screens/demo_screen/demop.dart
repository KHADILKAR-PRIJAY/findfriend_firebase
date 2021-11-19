import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/models/follower_list_model.dart';
import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/screens/demo_screen/chat_room.dart';
import 'package:find_friend/screens/demo_screen/search_page.dart';
import 'package:find_friend/services/dems.dart';
import 'package:find_friend/services/fetch_followers_list.dart';
import 'package:flutter/material.dart';
import 'constant_chat.dart';
import 'package:http/http.dart' as http;

class Demop extends StatefulWidget {
  const Demop({Key? key}) : super(key: key);

  @override
  _DemopState createState() => _DemopState();
}

class _DemopState extends State<Demop> {
  var fire;
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  Future geChatRooms(String userId) async {
    fire = await FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: userId)
        .snapshots();
    print(fire);
    return fire;
  }

  late List<Map<String, dynamic>> _allUsers;
  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _allUsers = fire;
    _foundUsers = _allUsers;

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundUsers[index]["id"].toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(_foundUsers[index]['name']),
                          subtitle: Text(
                              '${_foundUsers[index]["age"].toString()} years old'),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
