import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/models/coins_page_model.dart';
import 'package:find_friend/models/homes.dart';
import 'package:find_friend/screens/demo_screen/constant_chat.dart';
import 'package:find_friend/screens/navigation_drawer.dart';
import 'package:find_friend/screens/others_profile_page.dart';
import 'package:find_friend/screens/search_page.dart';
import 'package:find_friend/services/fetch_coin_page.dart';
import 'package:find_friend/services/fetch_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'Chat_pages/database.dart';
import 'coins_screen/coins.dart';

const String urll =
    'http://findfriend.notionprojects.tech/api/check_follow_button.php';

class HomePage extends StatefulWidget {
  static String id = 'home_page';
  final String userid;
  HomePage(this.userid);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  DatabaseMethods databaseMethods = DatabaseMethods();
  final String assetName = 'assets/images/logo_transparent.svg';
  late Future<Homes> home;
  late Future<Homes> vip;
  late Future<CoinsPageModelProfile> coinspagemodel;
  late int dataLength;
  late bool check;
  bool homeUnderline = true;
  bool VIPUnderline = false;
  late String username;
  late String fullname;
  late String profileimage;
  late bool isConnected;

  Future<void> Check_internet() async {
    // Simple check to see if we have Internet
    // ignore: avoid_print
    print('The statement \'this machine is connected to the Internet\' is: ');
    final isConnected = await InternetConnectionChecker().hasConnection;
    // ignore: avoid_print
    print(
      isConnected.toString(),
    );
    // returns a bool

    // We can also get an enum instead of a bool
    // ignore: avoid_print
    print(
        'Current status: ${await InternetConnectionChecker().connectionStatus}');
    // Prints either InternetConnectionStatus.connected
    // or InternetConnectionStatus.disconnected

    // actively listen for status updates
    StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_print
            print('Data connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            print('You are disconnected from the internet.');
            break;
        }
      },
    );

    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 30));
    await listener.cancel();
  }

  @override
  void initState() {
    //User presence-----------------------------------
    WidgetsBinding.instance!.addObserver(this);
    setStatus('online');

    //-------------------------------------------------
    Check_internet();
    check = true;

    //Home services-----------------------------------
    print('home page id:' + widget.userid);
    home = HomeServices.getHome(widget.userid).then((value) {
      setState(() {
        dataLength = value.data!.length;
      });
      return value;
    });

    //VIP services-----------------------------------
    print('vip page id:' + widget.userid);
    vip = HomeServices.getVIP(widget.userid).then((value) {
      setState(() {
        dataLength = value.data!.length;
      });
      return value;
    });

    //Coin services
    coinspagemodel = CoinPageServices.getCoinPage(widget.userid).then((value) {
      username = value.data[0].username;
      fullname = value.data[0].fullName;
      profileimage = value.data[0].profilePicture;
      return value;
    });

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setStatus('online');
    } else {
      setStatus('offline');
      DateTime currentPhoneDate = DateTime.now(); //DateTime

      Timestamp myTimeStamp =
          Timestamp.fromDate(currentPhoneDate); //To TimeStamp

      DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime

      print("current phone data is: $currentPhoneDate");
      print("current phone data is: $myDateTime");
      databaseMethods.updateUserInfo(
          ConstantChat.myId, myDateTime.toString(), 'timeStamp');
    }
  }

  void setStatus(String status) {
    databaseMethods.updateUserInfo(ConstantChat.myId, status, 'status');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: NavigationDrawer(widget.userid, username, fullname, profileimage),
      onDrawerChanged: (value) {
        setState(() {
          //Home services---------------
          home = HomeServices.getHome(widget.userid).then((value) {
            setState(() {
              dataLength = value.data!.length;
            });
            return value;
          });

          // VIP services----------------
          vip = HomeServices.getVIP(widget.userid).then((value) {
            setState(() {
              dataLength = value.data!.length;
            });
            return value;
          });
        });
      },
      appBar: AppBar(
        leadingWidth: 30,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        title: Container(
          child: SvgPicture.asset(assetName,
              semanticsLabel: 'Acme Logo', height: 50),
        ),
        centerTitle: false,
        actions: [
          CircleAvatar(
              backgroundColor: Colors.orange[300],
              radius: 7,
              child: Text(
                '\u{20B9}',
                style: TextStyle(fontSize: 9, color: Colors.black),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('548')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Coins(widget.userid)));
                //Navigator.pushNamed(context, Coins.id);
              },
            ),
          )
        ],
      ),
      body: (dataLength == 0)
          ? Center(
              child: Text(
              'no data.......',
              style: TextStyle(color: Colors.yellow),
            ))
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                check = true;
                                homeUnderline = true;
                                VIPUnderline = false;
                              });
                            },
                            child: Container(
                              width: 50,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  (homeUnderline)
                                      ? Container(
                                          color: Colors.white,
                                          height: 2,
                                          width: 50)
                                      : Container(height: 2)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                check = false;
                                homeUnderline = false;
                                VIPUnderline = true;
                              });
                            },
                            child: Container(
                              width: 50,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'VIP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  (VIPUnderline)
                                      ? Container(
                                          color: Colors.white,
                                          height: 2,
                                          width: 50)
                                      : Container(height: 2)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9.0),
                              child: Icon(Icons.search, color: Colors.white),
                            ),
                            onTap: () {
                              //Navigator.pushNamed(context, SearchPage.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchPage(widget.userid)));
                            },
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      FutureBuilder<Homes>(
                          future: (check) ? home : vip,
                          builder: (context, snapshot) {
                            return ListView.builder(
                              physics: PageScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.75),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: Image.network(
                                              '${snapshot.data!.data![index].profileImage}',
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment
                                                  //         .start,
                                                  children: [
                                                    Container(
                                                      // decoration: BoxDecoration(
                                                      //   border: Border(
                                                      //     right: BorderSide(
                                                      //         color:
                                                      //             Colors.white,
                                                      //         width: 1),
                                                      //     bottom: BorderSide(
                                                      //         color:
                                                      //             Colors.white,
                                                      //         width: 1),
                                                      //   ),
                                                      // ),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 20,
                                                                color: Colors
                                                                    .white),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Text(
                                                                '${snapshot.data!.data![index].city}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors
                                                              .transparent
                                                              .withOpacity(
                                                                  0.1)),
                                                    ),
                                                  ],
                                                ),

                                                ////////////
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Row(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                print(
                                                                    '${snapshot.data!.data![index].username}');
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => OthersProfilePage(
                                                                            username:
                                                                                '${snapshot.data!.data![index].username}',
                                                                            userid: widget
                                                                                .userid,
                                                                            othersid:
                                                                                '${snapshot.data!.data![index].userId}',
                                                                            otherUser_FCMtoken:
                                                                                '${snapshot.data!.data![index].fcmToken}')));
                                                                // Navigator.pushNamed(context,
                                                                //     OthersProfilePage.id,
                                                                //     arguments: {
                                                                //       'keyvalue': snapshot
                                                                //           .data!
                                                                //           .data![index]
                                                                //           .username
                                                                //     });
                                                              });
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF6A6A6C),
                                                              radius: 23,
                                                              child: CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          '${snapshot.data!.data![index].profileImage}')),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            left: 28,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF1FDEB3),
                                                              radius: 4,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(width: 12),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  '${snapshot.data!.data![index].username} '),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .solidCheckCircle,
                                                                color: Color(
                                                                    0xff2596BE),
                                                                size: 14,
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            '@ ${snapshot.data!.data![index].fullName}',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Align(
                                          //   alignment: Alignment.bottomRight,
                                          //   child: Padding(
                                          //     padding:
                                          //         const EdgeInsets.all(4.0),
                                          //     child: Column(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.end,
                                          //       children: [
                                          //         Stack(
                                          //           children: [
                                          //             GestureDetector(
                                          //               onTap: () {
                                          //                 setState(() {
                                          //                   print(
                                          //                       '${snapshot.data!.data![index].username}');
                                          //                   Navigator.push(
                                          //                       context,
                                          //                       MaterialPageRoute(
                                          //                           builder: (context) => OthersProfilePage(
                                          //                               username:
                                          //                                   '${snapshot.data!.data![index].username}',
                                          //                               userid: widget
                                          //                                   .userid,
                                          //                               othersid:
                                          //                                   '${snapshot.data!.data![index].userId}')));
                                          //                   // Navigator.pushNamed(context,
                                          //                   //     OthersProfilePage.id,
                                          //                   //     arguments: {
                                          //                   //       'keyvalue': snapshot
                                          //                   //           .data!
                                          //                   //           .data![index]
                                          //                   //           .username
                                          //                   //     });
                                          //                 });
                                          //               },
                                          //               child: CircleAvatar(
                                          //                 backgroundColor:
                                          //                     Color(0xFF6A6A6C),
                                          //                 radius: 19,
                                          //                 child: CircleAvatar(
                                          //                     radius: 19,
                                          //                     backgroundImage:
                                          //                         NetworkImage(
                                          //                             '${snapshot.data!.data![index].profileImage}')),
                                          //               ),
                                          //             ),
                                          //             Positioned(
                                          //               top: 0,
                                          //               left: 28,
                                          //               child: CircleAvatar(
                                          //                 backgroundColor:
                                          //                     Color(0xFF1FDEB3),
                                          //                 radius: 4,
                                          //               ),
                                          //             )
                                          //           ],
                                          //         ),
                                          //         // IconButton(
                                          //         //   icon: Icon(
                                          //         //       Icons
                                          //         //           .add_circle_outline,
                                          //         //       color: Colors.white),
                                          //         //   onPressed: () {},
                                          //         // ),
                                          //         Column(
                                          //           children: [
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(8.0),
                                          //               child: IconButton(
                                          //                 icon: Icon(
                                          //                     FontAwesomeIcons
                                          //                         .facebookMessenger,
                                          //                     color:
                                          //                         Colors.white),
                                          //                 onPressed: () {
                                          //                   Navigator.pushNamed(
                                          //                       context,
                                          //                       MessagePage.id);
                                          //                 },
                                          //               ),
                                          //             ),
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(8.0),
                                          //               child: IconButton(
                                          //                   icon: Icon(Icons
                                          //                       .video_call),
                                          //                   color: Colors.white,
                                          //                   onPressed: () {
                                          //                     ///////////////////////////////////////////
                                          //                     generatechannel()
                                          //                         .GenerateChannel()
                                          //                         .then(
                                          //                       (value) {
                                          //                         setState(
                                          //                           () {
                                          //                             cn =
                                          //                                 value;
                                          //                             print(cn.toString() +
                                          //                                 '////////////');
                                          //                             sendnotification(
                                          //                                 cn,
                                          //                                 '${snapshot.data!.data![index].fcmToken}',
                                          //                                 '0');
                                          //                             Navigator.push(
                                          //                                 context,
                                          //                                 MaterialPageRoute(
                                          //                                     builder: (context) => VideoCallPage(
                                          //                                           //user_id: widget.user_id,
                                          //                                           channelName: cn,
                                          //                                         )));
                                          //                           },
                                          //                         );
                                          //                       },
                                          //                     );
                                          //                   }),
                                          //             ),
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(8.0),
                                          //               child: IconButton(
                                          //                   icon: Icon(
                                          //                       Icons.phone),
                                          //                   color: Colors.white,
                                          //                   onPressed: () {
                                          //                     ///////////////////////////////////////////
                                          //                     generatechannel()
                                          //                         .GenerateChannel()
                                          //                         .then(
                                          //                       (value) {
                                          //                         setState(
                                          //                           () {
                                          //                             cn =
                                          //                                 value;
                                          //                             print(cn.toString() +
                                          //                                 '////////////');
                                          //                             sendnotification(
                                          //                                 cn,
                                          //                                 '${snapshot.data!.data![index].fcmToken}',
                                          //                                 '1');
                                          //                             Navigator.push(
                                          //                                 context,
                                          //                                 MaterialPageRoute(
                                          //                                     builder: (context) => VoiceCallPg(
                                          //                                           //user_id: widget.user_id,
                                          //                                           channelName: cn,
                                          //                                         )));
                                          //                           },
                                          //                         );
                                          //                       },
                                          //                     );
                                          //                   }),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
