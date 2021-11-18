import 'package:find_friend/components/drawer_button.dart';
import 'package:find_friend/screens/contact_us.dart';
import 'VIP_screen/verification.dart';
import 'VIP_screen/vip_member.dart';
import 'coins_screen/coins.dart';
import 'filter/filter_page.dart';
import 'package:find_friend/screens/subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  late String userid;
  late String username;
  late String fullname;
  late String profilepicture;
  NavigationDrawer(
      this.userid, this.username, this.fullname, this.profilepicture);

  //bool toggle = false;

  // void _showRatingAppDialog() {
  //   final _ratingDialog = RatingDialog(
  //     commentHint: 'hiiiiiiiiiiiiiiii',
  //     enableComment: true,
  //     ratingColor: Colors.amber,
  //     title: 'Let us know how we are doing',
  //     message: 'Rating this app and tell others what you think.'
  //         ' Add more description here if you want.',
  //     submitButton: 'Submit',
  //     onCancelled: () => print('cancelled'),
  //     onSubmitted: (response) {
  //       print('rating: ${response.rating}, '
  //           'comment: ${response.comment}');
  //
  //       if (response.rating < 3.0) {
  //         print('response.rating: ${response.rating}');
  //       } else {
  //         Container();
  //       }
  //     },
  //   );
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (context) => _ratingDialog,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            children: [
              Container(
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xFFD01B65),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 33,
                        child: CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(profilepicture)),
                      ),
                    ),
                    Text(fullname),
                    Text(
                      '@' + username,
                      style:
                          TextStyle(color: Color(0xffF0EEEF).withOpacity(0.6)),
                    ),
                    SizedBox(height: 2),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Transform.scale(
                    //       scale: 0.7,
                    //       child: CupertinoSwitch(
                    //         trackColor: Colors.red,
                    //         value: toggle,
                    //         onChanged: (bool value) {},
                    //         // onChanged: (value) {
                    //         //   setState(() {
                    //         //     toggle = value;
                    //         //   });
                    //         // },
                    //       ),
                    //     ),
                    //     Text(
                    //       'Online',
                    //       style: TextStyle(color: Color(0xFFF0EEEF)),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
              DrawerButton('Home', Icons.home, () {}),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Filter', Icons.grid_view_rounded, () {
                Navigator.pushNamed(context, FilterPage.id);
              }),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Verification', Icons.verified_user, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Verification(userid)));
                //Navigator.pushNamed(context, Verification.id);
              }),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Wallet', Icons.account_balance_wallet, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Coins(userid)));
                //Navigator.pushNamed(context, AddCoins.id);
              }),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('VIP', Icons.person, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VipMember(userid)));
              }),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Subscription', Icons.subscriptions, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Subscription(userid)));
                //Navigator.pushNamed(context, Subscription.id);
              }),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('About US', Icons.help_center, () {}),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Contact Us', Icons.account_box, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              }),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Share App', Icons.share, () {}),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Rate Us', Icons.star_half, () {}),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              DrawerButton('Log Out', Icons.logout_outlined, () {}),
            ],
          ),
        ),
      ),
    );
  }
}
