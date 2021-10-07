import 'dart:convert';
import 'package:find_friend/components/enter_field.dart';
import 'package:find_friend/screens/general_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/social_link.php';

class VIPMemberDetail extends StatefulWidget {
  static String id = 'vip_member_detail';
  late String userid;
  VIPMemberDetail(this.userid);

  @override
  _VIPMemberDetailState createState() => _VIPMemberDetailState();
}

class _VIPMemberDetailState extends State<VIPMemberDetail> {
  late String dropdownValue = Facebook;
  TextEditingController _email = TextEditingController();
  TextEditingController _fullName = TextEditingController();
  var retimage;
  late String Facebook;
  late String Twitter;
  late String Youtube;
  late String Instagram;

  var _value = 1;

  //String dropdownValue = 'One';

  Future _getpostImage(ImageSource source) async {
    print('getpost called');
    var image = await ImagePicker.platform.pickImage(source: source);
    retimage = image;
    return retimage;
  }

  Future _getLinks(String userid) async {
    var Response = await http
        .post(Uri.parse(url), body: {'token': '123456789', 'user_id': userid});
    print('Get Social Link services called ' + Response.body);
    var response = jsonDecode(Response.body);
    setState(() {
      Facebook = response['data']['fb_link'].toString();
      Twitter = response['data']['twitter_link'].toString();
      Youtube = response['data']['youtube_link'].toString();
      Instagram = response['data']['insta_link'].toString();
    });

    // print(Facebook);
    // print(Twitter);
    // print(Youtube);
    // print(Instagram);
  }

  Future _submitVipDetail(PickedFile image, BuildContext context, String userid,
      String link) async {
    print('submit vip detail post called');
    if (image != null) {
      var request = http.MultipartRequest("POST",
          Uri.parse('http://findfriend.notionprojects.tech/api/vip_user.php'));
      request.fields['user_id'] = userid;
      request.fields['token'] = '123456789';
      request.fields['social_link'] = link;
      var pic = await http.MultipartFile.fromPath("live_selfie", image.path);
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('----------------------------------------');
      print(responseString);
      var Response = jsonDecode(responseString);
      if (Response['status']) {
        final snackbar = SnackBar(
            duration: Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content:
                Text('${Response['message']}', textAlign: TextAlign.center));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        final snackbar = SnackBar(
            duration: Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content:
                Text('${Response['message']}', textAlign: TextAlign.center));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  @override
  void initState() {
    _getLinks(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("VIP Member's Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _getpostImage(ImageSource.camera);
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.camera_alt,
                                color: Colors.white.withOpacity(0.6), size: 40),
                            Text(
                              'Upload Live Selfie',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF6A6A6C),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EnterField(
                          'Enter Your Email',
                          'Email',
                          Container(
                            width: 0,
                            height: 0,
                          ),
                          _fullName),
                      EnterField(
                          'Enter Full Name',
                          'Full Name',
                          Container(
                            width: 0,
                            height: 0,
                          ),
                          _email),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 25.0),
                      //   child: Container(
                      //     height: 40,
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 10, horizontal: 10),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(0),
                      //       color: Color(0xff6A6A6C),
                      //       border: Border.all(color: Colors.grey),
                      //     ),
                      //     child: DropdownButtonHideUnderline(
                      //       child: DropdownButton<String>(
                      //         dropdownColor: Colors.grey,
                      //         value: dropdownValue,
                      //         onChanged: (newValue) {
                      //           setState(() {
                      //             dropdownValue = newValue!;
                      //             print(dropdownValue);
                      //           });
                      //         },
                      //         items: <String>[Facebook, Twitter, Youtube, Instagram]
                      //             .map<DropdownMenuItem<String>>((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 17),
                      Text('Select Your Social Media Profile'),
                      DropdownButton(
                        underline: Container(color: Colors.white, height: 1),
                        dropdownColor: Color(0xFF1E1E1E),
                        isExpanded: true,
                        value: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              Facebook,
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              Twitter,
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              Instagram,
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              Youtube,
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Attach Documents  📎'),
                            Text(
                              "\u2022 Aadharcard",
                              style: TextStyle(color: Color(0xff6A6A6C)),
                            ),
                            Text("\u2022 PANcard",
                                style: TextStyle(color: Color(0xff6A6A6C))),
                          ],
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(height: 46, width: 400),
                          child: ElevatedButton(
                            onPressed: () {
                              _submitVipDetail(retimage, context, widget.userid,
                                  dropdownValue);
                              //Navigator.pushNamed(context, GeneralPage.id);
                            },
                            child: Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: ButtonStyle(
                              elevation: null,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.black))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF2596BE),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

// String dropdownValue = 'One';
//
// @override
//
//   DropdownButton<String>(
//     value: dropdownValue,
//     icon: const Icon(Icons.arrow_downward),
//     iconSize: 24,
//     elevation: 16,
//     style: const TextStyle(color: Colors.deepPurple),
//     underline: Container(
//       height: 2,
//       color: Colors.deepPurpleAccent,
//     ),
//     onChanged: (String? newValue) {
//       setState(() {
//         dropdownValue = newValue!;
//       });
//     },
//     items: <String>['One', 'Two', 'Free', 'Four']
//         .map<DropdownMenuItem<String>>((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     }).toList(),
//   )
