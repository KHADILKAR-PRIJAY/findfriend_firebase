import 'package:find_friend/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:find_friend/screens/Activity-pages/notification.dart';
import 'package:find_friend/screens/call_history.dart';
import 'package:find_friend/screens/Chat_pages/chats.dart';
import 'package:find_friend/screens/User_Profile_pages/user_profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneralPage extends StatefulWidget {
  static String id = 'general_page';
  final String userid;
  const GeneralPage(this.userid);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  @override
  void initState() {
    print('general init id:' + widget.userid);
    super.initState();
  }

  final String assetName = 'assets/images/logo_transparent.svg';
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages() => <Widget>[
        HomePage(widget.userid),
        NotificationPage(widget.userid),
        CallHistory(widget.userid),
        Chats(widget.userid),
        UserProfile(widget.userid)
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: _pages().elementAt(_selectedIndex),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.black),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidComments),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
          ),
        ));
  }
}
