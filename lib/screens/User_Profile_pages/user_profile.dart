import 'dart:async';
import 'package:find_friend/models/getpost_model.dart';
import 'package:find_friend/screens/abouts_us.dart';
import 'package:find_friend/services/fetch_post.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:find_friend/models/profile_model.dart';
import '../../constants.dart';
import 'edit_profile.dart';
import 'followers.dart';
import 'package:find_friend/services/fetch_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class UserProfile extends StatefulWidget {
  final String userid;
  UserProfile(this.userid);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<Profile> profile;
  late Future<GetPostModel> getpostmodel;
  late int lenght;
  //late StreamController<Profile> _userController;

// Post Images by User.
  Future _getpostImage(ImageSource source) async {
    var image = await ImagePicker.platform.pickImage(source: source);
    if (image != null) {
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "http://findfriend.notionprojects.tech/api/users_post.php"));
      request.fields['user_id'] = widget.userid;
      request.fields['token'] = '123456789';
      var pic = await http.MultipartFile.fromPath("post", image.path);
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

  @override
  void initState() {
    // Stream=====================
    //  _userController = new StreamController();
    //  Timer.periodic(
    //      Duration(seconds: 20),
    //      (_) => ProfileServices.getProfile(widget.userid).then((value) async {
    //            _userController.add(value);
    //            return value;
    //          }));
/////////////////////////////////////////////////////////////////////////////////////
    super.initState();
    setState(() {
      profile = ProfileServices.getProfile(widget.userid);
      getpostmodel = PostServices.getPost(widget.userid).then((value) {
        setState(() {
          lenght = value.data.length;
        });

        return value;
      });
    });
  }

  void alertBox2() {
    showDialog(
        barrierColor: Colors.black,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey,
              contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 20),
              titlePadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Upload Photo',
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ],
              ),
              content: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(height: 46, width: 400),
                      child: ElevatedButton(
                        onPressed: () {
                          _getpostImage(ImageSource.camera).then((value) {
                            getpostmodel = PostServices.getPost(widget.userid)
                                .then((value) {
                              setState(() {
                                lenght = value.data.length;
                              });

                              return value;
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            SizedBox(width: 40),
                            Text(
                              'Camera',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 18),
                            ),
                          ],
                        ),
                        style: KButtonStyle,
                      ),
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(height: 46, width: 400),
                      child: ElevatedButton(
                        onPressed: () {
                          _getpostImage(ImageSource.gallery).then((value) {
                            getpostmodel = PostServices.getPost(widget.userid)
                                .then((value) {
                              setState(() {
                                lenght = value.data.length;
                              });

                              return value;
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            SizedBox(width: 40),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 18),
                            ),
                          ],
                        ),
                        style: KButtonStyle,
                      ),
                    ),
                  ],
                ),
              ),
            )).then((value) {
      setState(() {
        getpostmodel = PostServices.getPost(widget.userid).then((value) {
          setState(() {
            lenght = value.data.length;
          });

          return value;
        });
      });
    });
  }

  Future<Profile> returnValue() async {
    //await Navigator.pushNamed(context, EditProfile.id)
    await Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditProfile(widget.userid)))
        .then((value) {
      setState(() {
        profile = ProfileServices.getProfile(widget.userid);
      });
    });
    return Future.value(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<Profile>(
        future: profile,
        builder: (context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    backgroundColor: Colors.black,
                    title: Text(snapshot.data!.data[0].username),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.add_box),
                          onPressed: () {
                            alertBox2();
                          },
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xFFD01B65),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 38,
                                child: CircleAvatar(
                                    radius: 36,
                                    backgroundImage: NetworkImage(
                                        '${snapshot.data!.data[0].profilePicture}')),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 70,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(lenght.toString()),
                                  ),
                                  Text('Posts'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Followers(
                                              index: 1,
                                              userid: widget.userid,
                                              username:
                                                  '${snapshot.data!.data[0].username}',
                                              profileImg:
                                                  '${snapshot.data!.data[0].profilePicture}',
                                            )));
                              },
                              child: Container(
                                height: 60,
                                width: 70,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          '${snapshot.data!.data[0].followers}'),
                                    ),
                                    Text('Followers'),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Followers(
                                              index: 2,
                                              userid: widget.userid,
                                              username:
                                                  '${snapshot.data!.data[0].username}',
                                              profileImg:
                                                  '${snapshot.data!.data[0].profilePicture}')));
                                });
                              },
                              child: Container(
                                width: 70,
                                height: 60,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          '${snapshot.data!.data[0].following}'),
                                    ),
                                    Text('Following'),
                                  ],
                                ),
                              ),
                            ),
                            //SizedBox(height: 10)
                          ],
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AboutUs.id);
                            },
                            child: Container(
                              child: Text(
                                'About Us',
                                style: TextStyle(color: Color(0xff2596BE)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints.tightFor(
                                      height: 25,
                                      width: 80,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        returnValue();
                                      },
                                      child: Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      style: ButtonStyle(
                                        elevation: null,
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                side: BorderSide(
                                                    color: Color(0xff707070)))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${snapshot.data!.data[0].bio}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.6)),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Username:-\n'
                                    'Age :-\n'
                                    'Gender :-\n'
                                    'City :-\n',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6)),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      '   ${snapshot.data!.data[0].username} \n' +
                                          '   ${snapshot.data!.data[0].age}\n'
                                              '   Male\n'
                                              '   ${snapshot.data!.data[0].city}\n',
                                      style: TextStyle(fontSize: 13))
                                ],
                              ),
                              Container(
                                height: 90,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: Color(0xFFF6F4F4),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                      'Qualification :-\n'
                                      'Height :-\n'
                                      'Status :-\n'
                                      'DOB :-\n',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.6)))
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      '${snapshot.data!.data[0].qualification}\n'
                                      '${snapshot.data!.data[0].height} ft\n'
                                      '${snapshot.data!.data[0].maritalStatus}\n'
                                      '${snapshot.data!.data[0].birthday}\n',
                                      style: TextStyle(fontSize: 13))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                //backgroundImage: AssetImage('assets/images/instabg.jpg'),
                                backgroundColor: Color(0xff6A6A6C),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      // backgroundImage:
                                      //     AssetImage('assets/images/instabg.jpg'),
                                      radius: 27,
                                      child: Icon(
                                          FontAwesomeIcons.instagramSquare)),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff6A6A6C),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                      radius: 27,
                                      child: Icon(FontAwesomeIcons.twitter)),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff6A6A6C),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 27,
                                      child: Icon(FontAwesomeIcons.youtube)),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff6A6A6C),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 27,
                                    child: IconButton(
                                      icon: Icon(FontAwesomeIcons.facebookF),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<GetPostModel>(
                          future: getpostmodel,
                          builder: (context, snapshot) {
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemCount: snapshot.data!.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${snapshot.data!.data[index].post}',
                                      filterQuality: FilterQuality.medium,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    // child: Image.network(
                                    //     '${snapshot.data!.data[index].post}',
                                    //     fit: BoxFit.cover),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     body: StreamBuilder(
  //       stream: _userController.stream,
  //       builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
  //         switch (snapshot.connectionState) {
  //           case ConnectionState.none:
  //             return Center(
  //               child: Text('None'),
  //             );
  //             break;
  //           case ConnectionState.waiting:
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //             break;
  //           case ConnectionState.active:
  //             return Center(
  //               child: Text(
  //                 snapshot.data!.data[0].height == null
  //                     ? 'Null'
  //                     : snapshot.data!.data[0].height,
  //                 style: Theme.of(context).textTheme.display1,
  //               ),
  //             );
  //             break;
  //           case ConnectionState.done:
  //             print('Done is fucking here ${snapshot.data}');
  //             if (snapshot.hasData) {
  //               return Center(
  //                 child: Text(
  //                   snapshot.data!.data[0].height == null
  //                       ? 'Null'
  //                       : snapshot.data!.data[0].height,
  //                   style: Theme.of(context).textTheme.display1,
  //                 ),
  //               );
  //             } else if (snapshot.hasError) {
  //               return Text('Has Error');
  //             } else {
  //               return Text('Error');
  //             }
  //             break;
  //         }
  //         return Text('Non in Switch');
  //       },
  //     ),
  //   );
  // }
}
