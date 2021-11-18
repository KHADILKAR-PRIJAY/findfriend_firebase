import 'package:find_friend/models/follower_list_model.dart';
import 'package:find_friend/models/following_list_model.dart';
import 'package:find_friend/services/fetch_followers_list.dart';
import 'package:find_friend/services/fetch_following_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String unfollowURL =
    'http://findfriend.notionprojects.tech/api/unfollow_users.php';
const String removeURL =
    'http://findfriend.notionprojects.tech/api/remove_follow_user.php';

final InputDecoration textfieldDecoration = InputDecoration(
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
        borderRadius: BorderRadius.circular(10)));

class Followers extends StatefulWidget {
  final int index;
  static String id = 'followers';
  final String userid;
  final String profileImg;
  final String username;
  const Followers(
      {this.index = 1,
      required this.userid,
      required this.username,
      required this.profileImg});

  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  late int selectedIndex;
  late Future<FollowerListModel> followerlistmodel;
  late Future<FollowingListModel> followinglistmodel;
  late int lenghtFollowing;
  late int lenghtFollowers;
  TextEditingController _followerCont = TextEditingController();
  TextEditingController _followingCont = TextEditingController();
  List<FollowerListModelDatum> _foundUsersFollowers = [];
  List<FollowerListModelDatum> _allUsersFollowers = [];

  List<FollowingListModelDatum> _allUsersFollowing = [];
  List<FollowingListModelDatum> _foundUsersFollowing = [];

  @override
  void initState() {
    setState(() {
      selectedIndex = widget.index;
    });

    //followers-----------------------------------------------------------------------------------------------------
    FollowerListServices.getFollowerList(widget.userid).then((value) {
      setState(() {
        _allUsersFollowers = value.data;
        lenghtFollowers = value.data.length;
        _foundUsersFollowers = _allUsersFollowers;
      });
    });
    // at the beginning, all users are shown

    // followerlistmodel =
    //     FollowerListServices.getFollowerList(widget.userid).then((value) {
    //   setState(() {
    //     lenghtFollowers = value.data.length;
    //   });
    //   return value;
    // });

    //following---------------------------------------------------------------------------------------------------
    FollowingListServices.getFollowingList(widget.userid).then((value) {
      setState(() {
        _allUsersFollowing = value.data;
        lenghtFollowing = value.data.length;
        _foundUsersFollowing = _allUsersFollowing;
      });
    });
    // at the beginning, all users are shown

    // setState(() {
    //   followinglistmodel =
    //       FollowingListServices.getFollowingList(widget.userid).then((value) {
    //     setState(() {
    //       lenghtFollowing = value.data.length;
    //     });
    //     return value;
    //   });
    // });

    super.initState();
  }

  void _runFilterFollower(String enteredKeyword) {
    List<FollowerListModelDatum> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsersFollowers;
    } else {
      results = _allUsersFollowers
          .where((user) => user.username
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsersFollowers = results;
    });
  }

  void _runFilterFollowing(String enteredKeyword) {
    List<FollowingListModelDatum> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsersFollowing;
    } else {
      results = _allUsersFollowing
          .where((user) => user.username
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsersFollowing = results;
    });
  }

//Services----------------------------------------------------------------------------------------------------------------------------------------
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
      print('unfollowed successs');
    }
  }

  Future removeServices(String followerid, String followedid) async {
    var response = await http.post(
      Uri.parse(removeURL),
      body: {
        'token': '123456789',
        'follower_id': followerid,
        'followed_user_id': followedid
      },
    );
    print('Remove services called');
    print(response.body);
    if (response.statusCode == 200) {
      print('Removed successs');
    }
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
                  radius: 19, backgroundImage: NetworkImage(widget.profileImg)),
            ),
            SizedBox(width: 40),
            Text(
              widget.username,
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
                child: (selectedIndex == 1)
                    ? TextField(
                        controller: _followerCont,
                        decoration: textfieldDecoration,
                        onChanged: (value) => _runFilterFollower(value))
                    : TextField(
                        controller: _followingCont,
                        decoration: textfieldDecoration,
                        onChanged: (value) => _runFilterFollowing(value),
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
                          Text(' ${lenghtFollowers} Followers',
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
                            ' ${lenghtFollowing} Following',
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
      child: _foundUsersFollowers.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _foundUsersFollowers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF6A6A6C),
                    radius: 19,
                    child: CircleAvatar(
                        radius: 19,
                        backgroundImage: NetworkImage(
                            _foundUsersFollowers[index]
                                .profilePicture
                                .toString())),
                  ),
                  title: Text(_foundUsersFollowers[index].username.toString()),
                  subtitle: Text(_foundUsersFollowers[index].fullName,
                      style: TextStyle(color: Colors.grey)),
                  trailing: GestureDetector(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(height: 25, width: 80),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Center(
                          child: Text(
                            'Remove',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
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
                                                  color: Colors.white
                                                      .withOpacity(0.4)),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                removeServices(
                                                    _foundUsersFollowers[index]
                                                        .id
                                                        .toString(),
                                                    widget.userid);
                                                print(
                                                    _foundUsersFollowers[index]
                                                        .id
                                                        .toString());
                                              });
                                              print(index.toString());

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Remove',
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
                          followerlistmodel =
                              FollowerListServices.getFollowerList(
                                      widget.userid)
                                  .then((value) {
                            setState(() {
                              lenghtFollowers = value.data.length;
                            });
                            return value;
                          });
                        });
                      });
                    },
                  ),
                );
              })
          : Center(
              child: const Text(
                'No results found',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
    );
  }

  Widget FollowingView(BuildContext context) {
    return Expanded(
      child: _foundUsersFollowers.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _foundUsersFollowing.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF6A6A6C),
                      radius: 19,
                      child: CircleAvatar(
                          radius: 19,
                          backgroundImage: NetworkImage(
                              _foundUsersFollowing[index]
                                  .profilePicture
                                  .toString())),
                    ),
                    title:
                        Text(_foundUsersFollowing[index].username.toString()),
                    subtitle: Text(
                        _foundUsersFollowing[index].fullName.toString(),
                        style: TextStyle(color: Colors.grey)),
                    trailing: GestureDetector(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(height: 25, width: 80),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF2596BE),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Center(
                              child: Text(
                                'Following',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
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
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white
                                                          .withOpacity(0.4)),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    unfollowServices(
                                                            widget.userid,
                                                            _foundUsersFollowing[
                                                                    index]
                                                                .id
                                                                .toString())
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
                                          widget.userid)
                                      .then((value) {
                                setState(() {
                                  lenghtFollowing = value.data.length;
                                });
                                return value;
                              });
                            });
                          });
                        }));
              },
            )
          : Center(
              child:
                  Text('No user found', style: TextStyle(color: Colors.grey))),
    );
  }
}
