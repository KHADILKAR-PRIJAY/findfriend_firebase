import 'package:find_friend/screens/privacy_policy.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static String id = 'about_us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushNamed(context, PrivacyPolicy.id);
            Navigator.pop(context);
          },
        ),
        title: Text('About Us'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem ipsum',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 30),
            Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam '
              'nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.'
              ' At vero eos et accusam et justo duo dolores et ea rebum. '
              'Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
              ' Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod'
              ' tempor invidunt ut labore et dolore magna aliquyam erat,'
              ' sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.'
              ' Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum '
              'dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor'
              ' invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.'
              ' At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata '
              'sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
              'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. '
              'At vero eos et accusam et justo duo',
              style: TextStyle(
                  color: Color(0xffFFFFFF).withOpacity(0.6), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
