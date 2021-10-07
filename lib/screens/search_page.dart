import 'package:find_friend/models/search_model.dart';
import 'package:find_friend/screens/others_profile_page.dart';
import 'package:find_friend/screens/search_result_profile.dart';
import 'package:find_friend/services/fetch_search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static String id = 'search_page';
  String userid;
  SearchPage(this.userid);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<SearchModel> searchmodel;
  TextEditingController _username = TextEditingController();

  @override
  void initState() {
    searchmodel = SearchServices.getSearch('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(height: 40, width: 270),
                    child: TextField(
                      controller: _username,
                      onChanged: (value) {
                        setState(() {
                          value = _username.toString();
                          searchmodel =
                              SearchServices.getSearch('${_username.text}');
                        });
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Color(0xFFF0EEEF)),
                          fillColor: Color(0xFF6A6A6C),
                          prefixIcon:
                              Icon(Icons.search, color: Color(0xFFF0EEEF)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 10),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xff2596BE)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder<SearchModel>(
                    future: searchmodel,
                    builder: (context, snapshot) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, SearchResultProfile.id,
                                //     arguments: {
                                //       'example':
                                //           snapshot.data!.data[index].username
                                //     });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OthersProfilePage(
                                            userid: widget.userid,
                                            othersid:
                                                '${snapshot.data!.data[index].userId}',
                                            otherUser_FCMtoken:
                                                '${snapshot.data!.data[index].fcmToken}',
                                            username:
                                                '${snapshot.data!.data[index].username}')));
                              },
                              child: ListTile(
                                leading: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Color(0xFF6A6A6C),
                                      radius: 19,
                                      child: CircleAvatar(
                                          radius: 19,
                                          backgroundImage: NetworkImage(
                                              '${snapshot.data!.data[index].profileImage}')),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 28,
                                      child: (index == 1 || index == 4)
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Color(0xFF1FDEB3),
                                              radius: 4,
                                            )
                                          : Container(),
                                    )
                                  ],
                                ),
                                title: Text(
                                    '${snapshot.data!.data[index].username}'),
                                subtitle: (index == 1 || index == 4)
                                    ? Text('Active now',
                                        style: TextStyle(color: Colors.grey))
                                    : Text('Active 15m ago',
                                        style: TextStyle(color: Colors.grey)),
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
