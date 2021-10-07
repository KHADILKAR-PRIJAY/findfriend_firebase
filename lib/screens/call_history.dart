import 'package:flutter/material.dart';

class CallHistory extends StatelessWidget {
  CallHistory();
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
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 22,
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
                                  backgroundImage:
                                      AssetImage('assets/images/girl.jpg')),
                            ),
                          ),
                          title: Text(
                            'Lorem Ipsum',
                            style: TextStyle(
                              fontFamily: 'SegoeUI',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                (index == 5 ||
                                        index == 10 ||
                                        index == 3 ||
                                        index == 7)
                                    ? Icons.north_east
                                    : Icons.south_west,
                                color: (index == 5 ||
                                        index == 10 ||
                                        index == 3 ||
                                        index == 7)
                                    ? Color(0xff0FD97B)
                                    : Color(0xffFF4E4E),
                                size: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                                child: Text('  10 Jan,  20:21 am'),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            (index == 5 ||
                                    index == 10 ||
                                    index == 3 ||
                                    index == 7)
                                ? Icons.videocam_rounded
                                : Icons.call,
                            color: Color(0xFF2596BE),
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
