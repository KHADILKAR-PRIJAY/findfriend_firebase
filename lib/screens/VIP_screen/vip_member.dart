import 'package:find_friend/models/coins_page_model.dart';
import 'package:find_friend/services/fetch_coin_page.dart';
import 'package:flutter/material.dart';

class VipMember extends StatefulWidget {
  String userid;
  VipMember(this.userid);
  @override
  _VipMemberState createState() => _VipMemberState();
}

class _VipMemberState extends State<VipMember> {
  Object _selectedItem = 1;
  late String isVip;
  late Future<CoinsPageModelProfile> coinspagemodel;

  void checkIsVip(String userid) {
    coinspagemodel = CoinPageServices.getCoinPage(widget.userid).then((value) {
      setState(() {
        isVip = value.data[0].isVip;
      });

      return value;
    });
  }

  @override
  void initState() {
    checkIsVip('45');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('VIP Member'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          )
        ],
      ),
      body: (isVip == 'Yes')
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Charges For :-',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80,
                        child: Column(
                          children: [
                            Icon(Icons.video_call, color: Colors.white),
                            Text(' Call')
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.orange[300],
                                radius: 7,
                                child: Text(
                                  '\u{20B9}',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.black),
                                )),
                            Container(
                              height: 35,
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.black,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    dropdownColor: Colors.grey,
                                    value: _selectedItem,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("10"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          "20",
                                        ),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("30"), value: 3),
                                      DropdownMenuItem(
                                          child: Text("40"), value: 4)
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedItem = value!;
                                      });
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(height: 30, width: 100),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Change',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          style: ButtonStyle(
                            elevation: null,
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(color: Colors.black))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF2596BE),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80,
                        child: Column(
                          children: [
                            Icon(Icons.video_call, color: Colors.white),
                            Text(' Video Call')
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.orange[300],
                                radius: 7,
                                child: Text(
                                  '\u{20B9}',
                                  style: TextStyle(
                                      fontSize: 9, color: Colors.black),
                                )),
                            Container(
                              height: 35,
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.black,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    dropdownColor: Colors.grey,
                                    value: _selectedItem,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("10"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          "20",
                                        ),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("30"), value: 3),
                                      DropdownMenuItem(
                                          child: Text("40"), value: 4)
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedItem = value!;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(height: 30, width: 100),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Change',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          style: ButtonStyle(
                            elevation: null,
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(color: Colors.black))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF2596BE),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(height: 40, width: 100),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(height: 40, width: 100),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Ok',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ButtonStyle(
                            elevation: null,
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.black))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF6A6A6C),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Text(
              'You are not a VIP user!',
              style: TextStyle(color: Colors.grey),
            )),
    );
  }
}
