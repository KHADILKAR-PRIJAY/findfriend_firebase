import 'package:find_friend/screens/filter/everyone.dart';
import 'package:find_friend/screens/filter/women.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'men.dart';

class FilterPage extends StatefulWidget {
  static String id = 'filter-page';

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: CupertinoColors.black,
          title: Text('Date Filters'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_horiz),
            )
          ],
          bottom: TabBar(
            indicatorColor: Color(0xff2596BE),

            indicatorWeight: 5.0,
            labelColor: Color(0xff2596BE),
            labelPadding: EdgeInsets.only(top: 10.0),
            unselectedLabelColor: Colors.grey,
            //controller: _tabController,
            tabs: [Tab(text: 'Men'), Tab(text: 'Women'), Tab(text: 'Everyone')],
          ),
        ),
        body: TabBarView(
          children: [
            Men(userid: '45'),
            Women(userid: '45'),
            Everyone(userid: '45')
          ],
        ),
      ),
    );
  }
}
// Text(
// "I'm interested in...",
// style: TextStyle(color: Colors.grey),
// ),
