import 'package:find_friend/models/call_history_model.dart';
import 'package:find_friend/services/fetch_calling_history.dart';
import 'package:flutter/material.dart';

class CallHistory extends StatefulWidget {
  String userid;
  CallHistory(this.userid);

  @override
  _CallHistoryState createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
  late Future<CallingHistory> ch;

  String month({required String month}) {
    switch (month) {
      case '01':
        return 'Jan';
      case '02':
        return 'Feb';
      case '03':
        return 'Mar';
      case '04':
        return 'Apr';
      case '05':
        return 'May';
      case '06':
        return 'Jun';
      case '07':
        return 'Jul';
      case '08':
        return 'Aug';
      case '09':
        return 'Sep';
      case '10':
        return 'Oct';
      case '11':
        return 'Nov';
      case '12':
        return 'Dec';
      default:
        return " ";
    }
  }

  @override
  void initState() {
    ch = CallHistoryServices.getCallHistory(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calls'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<CallingHistory>(
                  future: ch,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.all(0),
                              leading: CircleAvatar(
                                radius: 23,
                                backgroundColor: Color(0xFFD01B65),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 21,
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          'https://findfriend.notionprojects.tech/upload/profile/no_image.jpg')),
                                ),
                              ),
                              title: Text(
                                '${snapshot.data.data[index].fullName}',
                                style: TextStyle(
                                  fontFamily: 'SegoeUI',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  ('${snapshot.data.data[index].callStatus}' ==
                                          'Incoming')
                                      ? Icon(
                                          Icons.south_west,
                                          color: Color(0xffFF4E4E),
                                          size: 15,
                                        )
                                      : Icon(
                                          Icons.north_east,
                                          color: Color(0xff0FD97B),
                                          size: 15,
                                        ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ' +
                                              snapshot
                                                  .data.data[index].callDateTime
                                                  .toString()
                                                  .substring(8, 10) +
                                              " " +
                                              month(
                                                  month: snapshot.data
                                                      .data[index].callDateTime
                                                      .toString()
                                                      .substring(5, 7)) +
                                              " " +
                                              snapshot
                                                  .data.data[index].callDateTime
                                                  .toString()
                                                  .substring(2, 4) +
                                              ',  ' +
                                              snapshot
                                                  .data.data[index].callDateTime
                                                  .toString()
                                                  .substring(10, 16) +
                                              ' ',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing:
                                  ('${snapshot.data.data[index].callType}' ==
                                          'video')
                                      ? Icon(
                                          Icons.videocam_rounded,
                                          color: Color(0xFF2596BE),
                                        )
                                      : Icon(
                                          Icons.call,
                                          color: Color(0xFF2596BE),
                                        ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
