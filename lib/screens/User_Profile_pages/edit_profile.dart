import 'dart:convert';
import 'package:find_friend/models/profile_model.dart';
import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/services/fetch_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_friend/components/enterfield_without.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  late final String userid;
  EditProfile(this.userid);

  static String id = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late Future<Profile> pro;
  late String initialmage;
  late String Day;
  late String Month;
  late String Year;
  DateTime currentDate = DateTime.now();
  DatabaseMethods databaseMethods = DatabaseMethods();

  TextEditingController _fullName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _qualification = TextEditingController();
  TextEditingController _height = TextEditingController();
  TextEditingController _status = TextEditingController();
  TextEditingController _DOB = TextEditingController();
  TextEditingController _facebook = TextEditingController();
  TextEditingController _youtube = TextEditingController();
  TextEditingController _instagram = TextEditingController();
  TextEditingController _twitter = TextEditingController();

  Future<void> postEditProfile(String user) async {
    String url = 'http://findfriend.notionprojects.tech/api/edit_profile.php';

    var Response = await http.post(Uri.parse(url), body: {
      'token': '123456789',
      'user_id': user,
      'full_name': '${_fullName.text.toString()}',
      'username': '${_userName.text.toString()}',
      'bio': '${_bio.text.toString()}',
      'gender': '${_gender.text.toString()}',
      'city': '${_city.text.toString()}',
      'qualification': '${_qualification.text.toString()}',
      'birthday': '${_DOB.text.toString()}',
      'height': '${_height.text.toString()}',
      'marital_status': '${_status.text.toString()}',
      'fb_link': '${_facebook.text.toString()}',
      'insta_link': '${_instagram.text.toString()}',
      'youtube_link': '${_youtube.text.toString()}',
      'twitter_link': '${_twitter.text.toString()}',
    });
    var response = jsonDecode(Response.body);
    print('edit profile pg' + Response.body);
    if (response['status']) {
      Navigator.pop(context);
    } else
      print('Error in edit profile');
  }

  Future _getpostImage(ImageSource source, String userid) async {
    print('getpostImage called');
    var image = await ImagePicker.platform.pickImage(source: source);

    if (image != null) {
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "http://findfriend.notionprojects.tech/api/change_profile_picture.php"));
      request.fields['user_id'] = userid;
      request.fields['token'] = '123456789';

      var pic =
          await http.MultipartFile.fromPath("profile_picture", image.path);
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
    } else {
      print('image not selected');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        Day = currentDate.day.toString();
        Year = currentDate.year.toString();
        Month = currentDate.month.toString();
        //print(currentDate);
      });
  }

  @override
  void initState() {
    setState(() {
      pro = ProfileServices.getProfile(widget.userid).then((value) {
        setState(() {
          _userName.text = value.data[0].username;
          _age.text = value.data[0].age;
          _gender.text = value.data[0].gender;
          _fullName.text = value.data[0].fullName;
          _bio.text = value.data[0].bio;
          _city.text = value.data[0].city;
          _DOB.text = value.data[0].birthday;
          _height.text = value.data[0].height;
          _qualification.text = value.data[0].qualification;
          _status.text = value.data[0].maritalStatus;
          _facebook.text = value.data[0].fbLink;
          _instagram.text = value.data[0].instaLink;
          _youtube.text = value.data[0].youtubeLink;
          _twitter.text = value.data[0].twitterLink;
          initialmage = value.data[0].profilePicture;
        });

        return value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          leadingWidth: 80,
          title: Text('Edit Profile'),
          leading: Center(
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: TextButton(
                      onPressed: () {
                        postEditProfile(widget.userid);
                      },
                      child: Text('Done',
                          style: TextStyle(color: Color(0xff2596BE))))),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<Profile>(
                  future: pro,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Color(0xFFD01B65),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 33,
                                    child: CircleAvatar(
                                        radius: 32,
                                        backgroundImage:
                                            NetworkImage(initialmage)),
                                  ),
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _getpostImage(ImageSource.gallery,
                                                widget.userid)
                                            .then((value) {
                                          setState(() {
                                            pro = ProfileServices.getProfile(
                                                    widget.userid)
                                                .then((value) {
                                              setState(() {
                                                initialmage = value
                                                    .data[0].profilePicture;
                                                databaseMethods.updateUserInfo(
                                                    widget.userid,
                                                    value
                                                        .data[0].profilePicture,
                                                    'profile');
                                              });
                                              return value;
                                            });
                                          });
                                        });
                                      });
                                    },
                                    child: Text(
                                      'Change Profile Picture',
                                      style:
                                          TextStyle(color: Color(0xff2596BE)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Full Name :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                  '${snapshot.data!.data[0].fullName}',
                                  _fullName,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Username :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                  '${snapshot.data!.data[0].username}',
                                  _userName,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Bio :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                                child: TextField(
                              controller: _bio,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                suffixIcon: null,
                                hintText:
                                    'Lorem ipsum dolor sit amet      Lorem ipsum dolor sit amet    Lorem ipsum dolor sit amet',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 4,
                              //expands: true,
                            )),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Container(
                        //         width: 100,
                        //         child: Text('Age :-',
                        //             style: TextStyle(color: Colors.grey)),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: EnterFieldWithout('22', _age,
                        //           icon: Container(
                        //             height: 0,
                        //             width: 0,
                        //           )),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Gender :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                '',
                                _gender,
                                icon: Container(
                                  height: 0,
                                  width: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('City :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                'Ahmedabad',
                                _city,
                                icon: Container(
                                  height: 0,
                                  width: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Qualification :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout('12th', _qualification,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Height :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout('6 ft', _height,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Status :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout('Single', _status,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('DOB :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout('01/01/1999', _DOB,
                                  icon: GestureDetector(
                                    onTap: () {
                                      _selectDate(context).then((value) {
                                        setState(() {
                                          _DOB.text = currentDate
                                              .toString()
                                              .substring(0, 10);
                                          print(_DOB.text);
                                        });
                                      });
                                    },
                                    child: Icon(Icons.calendar_today,
                                        color: Color(0xff2596BE), size: 18),
                                  ),
                                  readonly: true),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Facebook :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                  '🔗  Link Your Facebook Profile', _facebook,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Twitter :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                  '🔗  Link Your Twitter Profile', _twitter,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Youtube :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                  '🔗  Link Your Youtube Profile', _youtube,
                                  icon: Container(
                                    height: 0,
                                    width: 0,
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                child: Text('Instagram :-',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Expanded(
                              child: EnterFieldWithout(
                                '🔗  Link Your Instagram Profile',
                                _instagram,
                                icon: Container(
                                  height: 0,
                                  width: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ));
  }
}
