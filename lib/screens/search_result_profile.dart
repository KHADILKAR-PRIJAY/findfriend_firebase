// import 'package:find_friend/models/others_profile.dart';
// import 'package:find_friend/services/fetch_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class SearchResultProfile extends StatefulWidget {
//   static String id = 'search_result_profile';
//
//   @override
//   _SearchResultProfileState createState() => _SearchResultProfileState();
// }
//
// class _SearchResultProfileState extends State<SearchResultProfile> {
//   late Future<OthersProfile> rf;
//   @override
//   // void initState() {
//   //   // setState(() {
//   //   //   final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
//   //   //   // print('others sc init ' + arguments['example']);
//   //   //   pf = ProfileServices.getOthersProfile('${arguments['username']}');
//   //   // });
//   //
//   //   super.initState();
//   //   setState(() {
//   //     pf = ProfileServices.getOthersProfile('bhavin123');
//   //   });
//   // }
//
//   @override
//   void didChangeDependencies() {
//     final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
//     print('others sc init ' + arguments['example']);
//     rf = ProfileServices.getOthersProfileTwo('${arguments['example']}');
//
//     //pf = ProfileServices.getOthersProfile('${arguments['username']}');
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder<OthersProfile>(
//           future: rf,
//           builder: (context, snapshot) {
//             return Column(
//               children: [
//                 AppBar(
//                   backgroundColor: Colors.black,
//                   title: Text('${snapshot.data!.data[0].username}'),
//                   actions: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Icon(Icons.more_horiz),
//                     )
//                   ],
//                 ),
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Color(0xFFD01B65),
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.black,
//                                 radius: 38,
//                                 child: CircleAvatar(
//                                     radius: 36,
//                                     backgroundImage:
//                                         AssetImage('assets/images/girl.jpg')),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text('10'),
//                                         ),
//                                         Text('Posts'),
//                                       ],
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {},
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text('61'),
//                                           ),
//                                           Text('Followers'),
//                                         ],
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {},
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text('56'),
//                                           ),
//                                           Text('Following'),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 10),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: Container(
//                             child: Text(
//                               'About Us',
//                               style: TextStyle(color: Color(0xff2596BE)),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ConstrainedBox(
//                                   constraints: BoxConstraints.tightFor(
//                                       height: 25, width: 80),
//                                   child: ElevatedButton(
//                                     onPressed: null,
//                                     child: Text(
//                                       'Follow',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w900),
//                                     ),
//                                     style: ButtonStyle(
//                                         elevation: null,
//                                         shape: MaterialStateProperty.all<
//                                                 RoundedRectangleBorder>(
//                                             RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(4.0),
//                                                 side: BorderSide(
//                                                     color: Colors.black))),
//                                         backgroundColor:
//                                             MaterialStateProperty.all<Color>(
//                                           Color(0xFF2596BE),
//                                         )),
//                                   ),
//                                 ),
//                               ),
//                               Container(height: 20)
//                             ],
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt'
//                                         ' ut labore et dolore magna aliquya invidunt ut labore'
//                                         'ut labore et dolore magna aliquya invidunt ut labore',
//                                         style: TextStyle(
//                                             fontSize: 10,
//                                             color:
//                                                 Colors.white.withOpacity(0.6)),
//                                         textAlign: TextAlign.justify,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             children: [
//                               Icon(Icons.phone, color: Colors.white, size: 22),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text('Call',
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 14)),
//                               )
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Icon(Icons.video_call,
//                                   color: Colors.white, size: 22),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text('Video Call',
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 14)),
//                               )
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Icon(FontAwesomeIcons.facebookMessenger,
//                                   color: Colors.white, size: 22),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text('Message',
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 14)),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 Text(
//                                   'Username:-\n'
//                                   'Age :-\n'
//                                   'Gender :-\n'
//                                   'City :-\n',
//                                   style: TextStyle(
//                                       color: Colors.white.withOpacity(0.6)),
//                                 )
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                     '  Lorem ipsum\n'
//                                     '   22\n'
//                                     '   Male\n'
//                                     '   Delhi\n',
//                                     style: TextStyle(fontSize: 13))
//                               ],
//                             ),
//                             Container(
//                               height: 90,
//                               child: VerticalDivider(
//                                 thickness: 1,
//                                 color: Color(0xFFF6F4F4),
//                               ),
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                     'Username:-\n'
//                                     'Age :-\n'
//                                     'Gender :-\n'
//                                     'City :-\n',
//                                     style: TextStyle(
//                                         color: Colors.white.withOpacity(0.6)))
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                     '12\n'
//                                     '6 ft\n'
//                                     'Single\n'
//                                     '01/01/1999\n',
//                                     style: TextStyle(fontSize: 13))
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               //backgroundImage: AssetImage('assets/images/instabg.jpg'),
//                               backgroundColor: Color(0xff6A6A6C),
//                               child: CircleAvatar(
//                                 radius: 28,
//                                 backgroundColor: Colors.black,
//                                 child: CircleAvatar(
//                                     backgroundColor: Colors.transparent,
//                                     radius: 27,
//                                     child:
//                                         Icon(FontAwesomeIcons.instagramSquare)),
//                               ),
//                             ),
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Color(0xff6A6A6C),
//                               child: CircleAvatar(
//                                 radius: 28,
//                                 backgroundColor: Colors.black,
//                                 child: CircleAvatar(
//                                     radius: 27,
//                                     child: Icon(FontAwesomeIcons.twitter)),
//                               ),
//                             ),
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Color(0xff6A6A6C),
//                               child: CircleAvatar(
//                                 radius: 28,
//                                 backgroundColor: Colors.black,
//                                 child: CircleAvatar(
//                                     backgroundColor: Colors.red,
//                                     radius: 27,
//                                     child: Icon(FontAwesomeIcons.youtube)),
//                               ),
//                             ),
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Color(0xff6A6A6C),
//                               child: CircleAvatar(
//                                 radius: 28,
//                                 backgroundColor: Colors.black,
//                                 child: CircleAvatar(
//                                   radius: 27,
//                                   child: Icon(FontAwesomeIcons.facebookF),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                           child: GridView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3,
//                               ),
//                               itemCount: 10,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: 100,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(6),
//                                         image: DecorationImage(
//                                             fit: BoxFit.cover,
//                                             image: AssetImage(
//                                                 'assets/images/girl.jpg'))),
//                                   ),
//                                 );
//                               }))
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }
