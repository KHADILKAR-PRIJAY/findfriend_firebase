// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:find_friend/models/follower_list_model.dart';
// import 'package:find_friend/screens/Chat_pages/database.dart';
// import 'package:find_friend/screens/demo_screen/chat_room.dart';
// import 'package:find_friend/screens/demo_screen/search_page.dart';
// import 'package:find_friend/services/dems.dart';
// import 'package:find_friend/services/fetch_followers_list.dart';
// import 'package:flutter/material.dart';
// import 'constant_chat.dart';
// import 'package:http/http.dart' as http;
//
// const String url =
//     'http://findfriend.notionprojects.tech/api/followers_list.php';
//
// //
// // class Demop extends StatefulWidget {
// //   @override
// //   _DemopState createState() => _DemopState();
// // }
// //
// // class _DemopState extends State<Demop> {
// //   TextEditingController _usernamecontroller = TextEditingController();
// //
// //   TextEditingController _idcontroller = TextEditingController();
// //
// //   signme() {
// //     setState(() {
// //       Map<String, String> userInfoMap = {
// //         'name': _usernamecontroller.text,
// //         'id': _idcontroller.text,
// //         'profile':
// //             'https://crush.notionprojects.tech/upload/profile/1628845336_DESK.jpg'
// //       };
// //       DatabaseMethods databaseMethods =
// //           new DatabaseMethods().uploadUserInfo(userInfoMap, _idcontroller.text);
// //
// //       //DatabaseMethods().uploadUserInfoCustom();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('sign up'),
// //         centerTitle: true,
// //       ),
// //       backgroundColor: Colors.black,
// //       body: Padding(
// //         padding: const EdgeInsets.all(12.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text('username'),
// //             TextField(
// //               controller: _usernamecontroller,
// //             ),
// //             SizedBox(height: 25),
// //             Text('id'),
// //             TextField(controller: _idcontroller),
// //             SizedBox(height: 20),
// //             GestureDetector(
// //               onTap: () {
// //                 signme();
// //               },
// //               child: Container(
// //                 height: 30,
// //                 width: 150,
// //                 color: Colors.blue,
// //                 child: Center(child: Text('sign up')),
// //               ),
// //             ),
// //             SizedBox(height: 30),
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => SearchPAGE()));
// //               },
// //               child: Container(
// //                 height: 30,
// //                 width: 150,
// //                 color: Colors.orange,
// //                 child: Center(child: Text('Go to Search Page')),
// //               ),
// //             ),
// //             SizedBox(height: 30),
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => ChatRoom()));
// //               },
// //               child: Container(
// //                 height: 30,
// //                 width: 150,
// //                 color: Colors.pinkAccent,
// //                 child: Center(child: Text('Go to Chat lobby')),
// //               ),
// //             ),
// //             SizedBox(height: 30),
// //             GestureDetector(
// //               onTap: () {
// //                 DatabaseMethods databaseMethods = new DatabaseMethods();
// //                 databaseMethods.getChatRooms(ConstantChat.myName).then((value) {
// //                   setState(() async {
// //                     await FirebaseFirestore.instance
// //                         .collection(((value as QuerySnapshot<Object?>))
// //                             .docs[0]
// //                             .get('chatRoomid'))
// //                         .doc()
// //                         .update({
// //                       'users': ['', '1']
// //                     });
// //                   });
// //                 });
// //               },
// //               child: Container(
// //                 height: 30,
// //                 width: 150,
// //                 color: Colors.green,
// //                 child: Center(child: Text('UpDATE')),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// class Demop extends StatefulWidget {
//   const Demop({Key? key}) : super(key: key);
//
//   @override
//   _DemopState createState() => _DemopState();
// }
//
// class _DemopState extends State<Demop> {
//   late final List _allUsers;
//   // This holds a list of fiction users
//   // You can use data fetched from a database or a server as well
//   // late final List<Map<String, dynamic>> _allUsers = [
//   //   {"id": 1, "name": "Andy", "age": 29},
//   //   {"id": 2, "name": "Aragon", "age": 40},
//   //   {"id": 3, "name": "Bob", "age": 5},
//   //   {"id": 4, "name": "Barbara", "age": 35},
//   //   {"id": 5, "name": "Candy", "age": 21},
//   //   {"id": 6, "name": "Colin", "age": 55},
//   //   {"id": 7, "name": "Audra", "age": 30},
//   //   {"id": 8, "name": "Banana", "age": 14},
//   //   {"id": 9, "name": "Caversky", "age": 100},
//   //   {"id": 10, "name": "Becky", "age": 32},
//   // ];
//
//   // This list holds the data for the list view
//   List _foundUsers = [];
//   @override
//   initState() {
//     _allUsers = FollowerListServices.getimages('45');
//     // at the beginning, all users are shown
//     _foundUsers = _allUsers;
//     super.initState();
//   }
//
//   // This function is called whenever the text field changes
//   void _runFilter(String enteredKeyword) {
//     List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = _allUsers;
//     } else {
//       results = _allUsers
//           .where((user) =>
//               user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }
//
//     // Refresh the UI
//     setState(() {
//       _foundUsers = results;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white.withOpacity(0.7),
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               onChanged: (value) => _runFilter(value),
//               decoration: const InputDecoration(
//                   labelText: 'Search', suffixIcon: Icon(Icons.search)),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: _foundUsers.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: _foundUsers.length,
//                       itemBuilder: (context, index) => Card(
//                         key: ValueKey(_foundUsers[index]["id"]),
//                         color: Colors.black,
//                         elevation: 4,
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: ListTile(
//                           leading: Text(
//                             _foundUsers[index]["id"].toString(),
//                             style: const TextStyle(fontSize: 24),
//                           ),
//                           title: Text(_foundUsers[index]['name']),
//                           subtitle: Text(
//                               '${_foundUsers[index]["age"].toString()} years old'),
//                         ),
//                       ),
//                     )
//                   : const Text(
//                       'No results found',
//                       style: TextStyle(fontSize: 24),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
