import 'package:find_friend/models/follower_list_model.dart';
import 'package:find_friend/models/following_list_model.dart';
import 'package:find_friend/services/fetch_followers_list.dart';
import 'package:find_friend/services/fetch_following_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String unfollowURL =
    'http://findfriend.notionprojects.tech/api/unfollow_users.php';

class Followers extends StatefulWidget {
  final int index;
  static String id = 'followers';
  final String userid;
  final String followers_no;
  final String following_no;

  const Followers(
      {this.index = 1,
      required this.userid,
      required this.followers_no,
      required this.following_no});

  //const Followers({Key? key, this.index = 1}) : super(key: key);

  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  late int selectedIndex;

  late Future<FollowerListModel> followerlistmodel;

  late Future<FollowingListModel> followinglistmodel;

  @override
  void initState() {
    setState(() {
      selectedIndex = widget.index;
    });
    //followers-----------------------------------------------------------------------------------------------------
    followerlistmodel =
        FollowerListServices.getFollowerList(widget.userid).then((value) {
      setState(() {});
      return value;
    });
    print('Followers_view id:');

    //following---------------------------------------------------------------------------------------------------
    print('Following_view id:');
    super.initState();
    setState(() {
      followinglistmodel =
          FollowingListServices.getFollowingList(widget.userid);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
              'Lorem ipsum',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 45),
              child: GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, SearchPage.id);
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Text(' ${widget.followers_no} Followers',
                              style: TextStyle(
                                  color: (selectedIndex == 1)
                                      ? Color(0xFF2596BE)
                                      : Colors.grey,
                                  fontWeight: FontWeight.w700)),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              color: (selectedIndex == 1)
                                  ? Color(0xFF2596BE)
                                  : Colors.black,
                              height: 3,
                              width: 90,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            ' ${widget.following_no} Following',
                            style: TextStyle(
                                color: (selectedIndex == 2)
                                    ? Color(0xFF2596BE)
                                    : Colors.grey,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              color: (selectedIndex == 2)
                                  ? Color(0xFF2596BE)
                                  : Colors.black,
                              height: 3,
                              width: 90,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (selectedIndex == 1)
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "All Followers",
                          style: TextStyle(fontSize: 19),
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Sort by Default',
                          style: TextStyle(fontSize: 19)),
                    ),
                  ),
            (selectedIndex == 1)
                ? FollowersView(context)
                : FollowingView(context),
          ],
        ),
      ),
    );
  }

  Widget FollowersView(BuildContext context) {
    return Expanded(
      child: FutureBuilder<FollowerListModel>(
          future: followerlistmodel,
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF6A6A6C),
                      radius: 19,
                      child: CircleAvatar(
                          radius: 19,
                          backgroundImage:
                              AssetImage('assets/images/girl.jpg')),
                    ),
                    title: Text('${snapshot.data!.data[index].username}'),
                    subtitle: Text('${snapshot.data!.data[index].fullName}',
                        style: TextStyle(color: Colors.grey)),
                    trailing: RemoveButton(),
                  );
                });
          }),
    );
  }

  Widget FollowingView(BuildContext context) {
    Future unfollowServices(String followerid, String followedid) async {
      var response = await http.post(
        Uri.parse(unfollowURL),
        body: {
          'token': '123456789',
          'follower_id': followerid,
          'followed_user_id': followedid
        },
      );
      print('Unfollow services called');
      print(response.body);
      if (response.statusCode == 200) {
        print('successs');
      }
    }

    return Expanded(
      child: FutureBuilder<FollowingListModel>(
        future: followinglistmodel,
        builder: (context, snapshot) {
          return (snapshot.data!.status)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF6A6A6C),
                          radius: 19,
                          child: CircleAvatar(
                              radius: 19,
                              backgroundImage:
                                  AssetImage('assets/images/girl.jpg')),
                        ),
                        title: Text('${snapshot.data!.data[index].username}'),
                        subtitle: Text('${snapshot.data!.data[index].fullName}',
                            style: TextStyle(color: Colors.grey)),
                        trailing: GestureDetector(
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: 25, width: 80),
                              child: Text(
                                'Following',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        contentPadding: EdgeInsets.zero,
                                        titlePadding: EdgeInsets.all(120),
                                        title: Container(
                                          color: Colors.transparent,
                                          height: 20,
                                        ),
                                        content: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff1E1E1E),
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          height: 200,
                                          width: 400,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                CircleAvatar(
                                                    radius: 16,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/girl.jpg')),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.4)),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        unfollowServices(
                                                                widget.userid,
                                                                snapshot
                                                                    .data!
                                                                    .data[index]
                                                                    .id)
                                                            .then((value) {});
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Unfollow',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.red),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        actionsPadding: EdgeInsets.zero,
                                        buttonPadding: EdgeInsets.zero,
                                        actions: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent),
                                            height: 15,
                                            width: 400,
                                          ),
                                          Center(
                                            child: Container(
                                              height: 40,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff1E1E1E),
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              child: FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          )
                                        ],
                                      )).then((value) {
                                setState(() {
                                  followinglistmodel =
                                      FollowingListServices.getFollowingList(
                                          widget.userid);
                                });
                              });
                            }));
                  },
                )
              : Center(
                  child: Text('No user found',
                      style: TextStyle(color: Colors.grey)));
        },
      ),
    );
  }
}

class FollowingButton extends StatefulWidget {
  late final String userid;
  final String followedid;
  final VoidCallback onPressed;
  FollowingButton(this.userid, this.followedid, this.onPressed);

  @override
  _FollowingButtonState createState() => _FollowingButtonState();
}

class _FollowingButtonState extends State<FollowingButton> {
  Future unfollowServices(String followerid, String followedid) async {
    var response = await http.post(
      Uri.parse(unfollowURL),
      body: {
        'token': '123456789',
        'follower_id': followerid,
        'followed_user_id': followedid
      },
    );
    print('Unfollow services called');
    print(response.body);
    if (response.statusCode == 200) {
      print('successs');
    }
  }

  void alertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.all(120),
              title: Container(
                color: Colors.transparent,
                height: 20,
              ),
              content: Container(
                decoration: BoxDecoration(
                    color: Color(0xff1E1E1E),
                    borderRadius: BorderRadius.circular(7)),
                height: 200,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                          radius: 16,
                          backgroundImage:
                              AssetImage('assets/images/girl.jpg')),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.4)),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              unfollowServices(widget.userid, widget.followedid)
                                  .then((value) {});
                              widget.onPressed;
                            });

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Unfollow',
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ))
                    ],
                  ),
                ),
              ),
              actionsPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              actions: [
                Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  height: 15,
                  width: 400,
                ),
                Center(
                  child: Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        borderRadius: BorderRadius.circular(7)),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 25, width: 80),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            alertBox();
            widget.onPressed;
          });
        },
        child: Text(
          'Following',
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

class RemoveButton extends StatefulWidget {
  @override
  _RemoveButtonState createState() => _RemoveButtonState();
}

class _RemoveButtonState extends State<RemoveButton> {
  void alertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.all(120),
              title: Container(
                color: Colors.transparent,
                height: 20,
              ),
              content: Container(
                decoration: BoxDecoration(
                    color: Color(0xff1E1E1E),
                    borderRadius: BorderRadius.circular(7)),
                height: 200,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                          radius: 16,
                          backgroundImage:
                              AssetImage('assets/images/girl.jpg')),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Text('Remove followers ?',
                              style: TextStyle(fontSize: 13)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.4)),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Remove',
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ))
                    ],
                  ),
                ),
              ),
              actionsPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              actions: [
                Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  height: 15,
                  width: 400,
                ),
                Center(
                  child: Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        borderRadius: BorderRadius.circular(7)),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 25, width: 80),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            alertBox();
          });
        },
        child: Text(
          'Remove',
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
        ),
        style: ButtonStyle(
          elevation: null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Colors.white))),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xff000000),
          ),
        ),
      ),
    );
  }
}
// FollowingButton(
// widget.userid,
// '${snapshot.data!.data[index].id}',
// () {
// setState(() {
// followinglistmodel =
// FollowingListServices.getFollowingList(
// widget.userid)
//     .then((value) {
// setState(() {
// followinglistmodel =
// FollowingListServices.getFollowingList(
// widget.userid);
// });
// return value;
// });
// });
// },
// )
