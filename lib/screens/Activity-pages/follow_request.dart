import 'package:find_friend/models/get_follow_request_model.dart';
import 'package:find_friend/services/fetch_follow_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/confirm_follow_request.php';
const String url2 =
    'http://findfriend.notionprojects.tech/api/delete_follow_request.php';

class FollowRequest extends StatefulWidget {
  final String userid;
  FollowRequest(this.userid);

  @override
  _FollowRequestState createState() => _FollowRequestState();
}

class _FollowRequestState extends State<FollowRequest> {
  late Future<GetFollowReqModel> reqModel;

  Future confirmRequestServices(String userid, String followerid) async {
    var response = await http.post(
      Uri.parse(url),
      body: {
        'token': '123456789',
        'follower_id': userid,
        'followed_user_id': followerid
      },
    );
    print('Confirm request services called ' + response.body);
  }

  Future deleteRequestServices(String userid, String deleteid) async {
    var response = await http.post(
      Uri.parse(url2),
      body: {
        'token': '123456789',
        'follower_id': deleteid,
        'followed_user_id': userid
      },
    );
    print('Delete request services called ' + response.body);
  }

  @override
  void initState() {
    reqModel = FollowRequestServices.getRequests(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Follow Request'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: FutureBuilder<GetFollowReqModel>(
          future: reqModel,
          builder: (context, snapshot) {
            return (snapshot.data!.data.length != 0)
                ? ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: Color(0xFFD01B65),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 21,
                                child: CircleAvatar(
                                    radius: 19,
                                    backgroundImage: NetworkImage(
                                        '${snapshot.data!.data[index].profileImage}')),
                              ),
                            ),
                            Container(
                              width: 125,
                              height: 40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${snapshot.data!.data[index].fullName}'),
                                  Text(
                                    '${snapshot.data!.data[index].username}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: 25, width: 75),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    confirmRequestServices(widget.userid,
                                            '${snapshot.data!.data[index].followerId}')
                                        .then((value) {
                                      setState(() {
                                        reqModel =
                                            FollowRequestServices.getRequests(
                                                widget.userid);
                                      });
                                    });
                                    print(
                                        '${widget.userid} confirmed request of  ${snapshot.data!.data[index].followerId}');
                                  });
                                },
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900),
                                ),
                                style: ButtonStyle(
                                  elevation: null,
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          side:
                                              BorderSide(color: Colors.black))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xFF2596BE),
                                  ),
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                height: 25,
                                width: 75,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  deleteRequestServices(widget.userid,
                                          '${snapshot.data!.data[index].followerId}')
                                      .then((value) {
                                    setState(() {
                                      reqModel =
                                          FollowRequestServices.getRequests(
                                              widget.userid);
                                      print(
                                          '${widget.userid} deleted request of ${snapshot.data!.data[index].followerId}');
                                    });
                                  });
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900),
                                ),
                                style: ButtonStyle(
                                  elevation: null,
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          side:
                                              BorderSide(color: Colors.white))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xFF000000),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                    'No Request',
                    style: TextStyle(color: Colors.grey),
                  ));
          }),
    );
  }
}
