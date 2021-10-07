import 'package:find_friend/components/rounded_button.dart';
import 'package:find_friend/screens/Activity-pages/follow_request.dart';
import 'package:find_friend/screens/others_profile_page.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  String userid;
  NotificationPage(this.userid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Activity',
                style: TextStyle(fontSize: 26),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FollowRequest(userid)));
              },
              child: ListTile(
                subtitle: Text(
                  'Approve or Ignore Requests',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4), fontSize: 11),
                ),
                title: Text('Follow Requests'),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.2,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person_add_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Today'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, OthersProfilePage.id);
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20.2,
                  backgroundColor: Color(0xFFD01B65),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 19,
                    child: CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage('assets/images/girl.jpg')),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Lorem ipsum  ',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      TextSpan(
                          text:
                              'dolor sit amet, consetetur sadipscing elitr, sed diam .'),
                    ],
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                      height: 40,
                      child: Image.asset('assets/images/beach.jpg')),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text('This Week'),
            ),
            Expanded(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20.2,
                        backgroundColor: Color(0xFFD01B65),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 19,
                          child: CircleAvatar(
                              radius: 16,
                              backgroundImage:
                                  AssetImage('assets/images/girl.jpg')),
                        ),
                      ),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Lorem ipsum  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                            TextSpan(
                                text:
                                    'dolor sit amet, consetetur sadipscing elitr, sed diam .'),
                          ],
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: (index == 2 || index == 4)
                            ? ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    height: 20, width: 57),
                                child: ElevatedButton(
                                  onPressed: null,
                                  child: Text(
                                    'Follow',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                  style: ButtonStyle(
                                    elevation: null,
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            side: BorderSide(
                                                color: Colors.black))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color(0xFF2596BE),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 40,
                                child: Image.asset('assets/images/beach.jpg')),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
