import 'dart:convert';
import 'package:find_friend/screens/demo_screen/constant_chat.dart';
import 'package:find_friend/screens/general_page.dart';
import 'package:find_friend/screens/Validator/validators.dart';
import 'package:flutter/material.dart';
import 'package:find_friend/components/logo.dart';
import 'package:find_friend/components/enter_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/login.php';

class LogIn extends StatefulWidget {
  static String id = 'log_in';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool hide = true;
  var _key = GlobalKey<FormState>();

  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future<void> postLogIn() async {
    var Response = await http.post(Uri.parse(url), body: {
      'token': '123456789',
      'username': '${_userName.text.toString()}',
      'password': '${_password.text.toString()}'
    });
    var response = jsonDecode(Response.body);

    print('user id log in' + response['data']['user_id']);
    if (Response.statusCode == 200) {
      ConstantChat.myId = response['data']['user_id'];
      ConstantChat.myName = _userName.text;
      //Navigator.pushNamed(context, GeneralPage.id);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GeneralPage(response['data']['user_id'])));

      _password.clear();
      _userName.clear();
    }
    print('login_pg : ' + Response.body);
  }

  void validate() {
    if (_key.currentState!.validate()) {
      print('validate');
      postLogIn();
    } else {
      print('not validated');
    }
  }

  //late bool agree;

  // void alertBox2() {
  //   showDialog(
  //       barrierColor: Colors.black,
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             backgroundColor: Colors.grey,
  //             contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 20),
  //             titlePadding: EdgeInsets.all(0),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(20.0),
  //               ),
  //             ),
  //             title: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: Text(
  //                     'Reminder',
  //                     style: TextStyle(fontSize: 21, color: Colors.white),
  //                   ),
  //                 ),
  //                 Divider(
  //                   thickness: 2,
  //                   color: Colors.black,
  //                 ),
  //               ],
  //             ),
  //             content: Container(
  //               height: 299,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Text(
  //                     'Allow access to the following permission for better services.',
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(fontSize: 12),
  //                   ),
  //                   ConstrainedBox(
  //                     constraints:
  //                         BoxConstraints.tightFor(height: 46, width: 400),
  //                     child: ElevatedButton(
  //                       onPressed: () {},
  //                       child: Row(
  //                         children: [
  //                           Icon(
  //                             Icons.camera_alt,
  //                             color: Colors.white,
  //                           ),
  //                           SizedBox(width: 40),
  //                           Text(
  //                             'Camera',
  //                             style: TextStyle(
  //                                 color: Color(0xFFFFFFFF), fontSize: 18),
  //                           ),
  //                         ],
  //                       ),
  //                       style: KButtonStyle,
  //                     ),
  //                   ),
  //                   ConstrainedBox(
  //                     constraints:
  //                         BoxConstraints.tightFor(height: 46, width: 400),
  //                     child: ElevatedButton(
  //                       onPressed: () {},
  //                       child: Row(
  //                         children: [
  //                           Icon(
  //                             Icons.phone,
  //                             color: Colors.white,
  //                           ),
  //                           SizedBox(width: 40),
  //                           Text(
  //                             'Call',
  //                             style: TextStyle(
  //                                 color: Color(0xFFFFFFFF), fontSize: 18),
  //                           ),
  //                         ],
  //                       ),
  //                       style: KButtonStyle,
  //                     ),
  //                   ),
  //                   ConstrainedBox(
  //                     constraints:
  //                         BoxConstraints.tightFor(height: 46, width: 400),
  //                     child: ElevatedButton(
  //                       onPressed: () {},
  //                       child: Row(
  //                         children: [
  //                           Icon(
  //                             Icons.mic_rounded,
  //                             color: Colors.white,
  //                           ),
  //                           SizedBox(width: 40),
  //                           Text(
  //                             'Microphone',
  //                             style: TextStyle(
  //                                 color: Color(0xFFFFFFFF), fontSize: 18),
  //                           ),
  //                         ],
  //                       ),
  //                       style: KButtonStyle,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actionsPadding: EdgeInsets.all(10),
  //             buttonPadding: EdgeInsets.zero,
  //             actions: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(15.0),
  //                     child: Container(
  //                       height: 40,
  //                       width: 200,
  //                       decoration: BoxDecoration(
  //                           color: Colors.black,
  //                           borderRadius: BorderRadius.circular(5)),
  //                       child: FlatButton(
  //                           onPressed: () {
  //                             agree = true;
  //                             postLogIn();
  //                           },
  //                           child: Text(
  //                             'Allow All',
  //                             style:
  //                                 TextStyle(fontSize: 18, color: Colors.white),
  //                           )),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ));
  // }

  // void alertBox() {
  //   showDialog(
  //       barrierColor: Colors.black,
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             backgroundColor: Colors.grey,
  //             contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 1),
  //             titlePadding: EdgeInsets.all(0),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(20.0),
  //               ),
  //             ),
  //             title: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(25.0),
  //                   child: Text(
  //                     'Reminder',
  //                     style: TextStyle(fontSize: 21, color: Colors.white),
  //                   ),
  //                 ),
  //                 Divider(
  //                   thickness: 2,
  //                   color: Colors.black,
  //                 ),
  //               ],
  //             ),
  //             content: Container(
  //               height: 299,
  //               child: RichText(
  //                 text: TextSpan(children: [
  //                   TextSpan(
  //                     text:
  //                         'Please observe there terms when you submit You Content:\n\n'
  //                         ' You are prohibited from posting and agree not to post any objectionable content which includes, but is not limited to : Sexually Explicit Material, Violence and Bullying, hate Speech, Sensitive Event, illegal Activity, and intellectual Property Infringement. Should you violate the Terms, your account will be suspended.\n\n'
  //                         ' If you spot any violations, please inform us using the Repory System built in our app. any convicted violators shall be banned immediately. \n\n'
  //                         'for more detailed information, please refer to findfriend ',
  //                     style: TextStyle(fontSize: 12),
  //                   ),
  //                   TextSpan(
  //                       text: 'Terms of Use.',
  //                       style: TextStyle(
  //                           color: Color(0xff2596BE),
  //                           decoration: TextDecoration.underline))
  //                 ], style: TextStyle(color: Color(0xffF0EEEF))),
  //               ),
  //             ),
  //             actionsPadding: EdgeInsets.zero,
  //             buttonPadding: EdgeInsets.zero,
  //             actions: [
  //               Divider(
  //                 thickness: 2,
  //                 color: Colors.black,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(10.0),
  //                     child: FlatButton(
  //                         onPressed: () {
  //                           agree = false;
  //                           Navigator.pop(context);
  //                           alertBox2();
  //                         },
  //                         child: Text(
  //                           'Refuse',
  //                           style: TextStyle(fontSize: 18, color: Colors.white),
  //                         )),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(10.0),
  //                     child: Container(
  //                       height: 40,
  //                       width: 102,
  //                       decoration: BoxDecoration(
  //                           color: Colors.black,
  //                           borderRadius: BorderRadius.circular(5)),
  //                       child: FlatButton(
  //                           onPressed: () {
  //                             agree = true;
  //                             postLogIn();
  //                           },
  //                           child: Text(
  //                             'Agree',
  //                             style:
  //                                 TextStyle(fontSize: 18, color: Colors.white),
  //                           )),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Logo(),
                Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 40),
                EnterField(
                    'Enter Username',
                    '',
                    Container(
                      height: 0,
                      width: 0,
                    ),
                    _userName),
                EnterField(
                    'Enter 6 Digit Password',
                    '',
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          (hide) ? hide = false : hide = true;
                        });
                      },
                      child: (hide)
                          ? Icon(FontAwesomeIcons.eyeSlash, color: Colors.white)
                          : Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.white,
                            ),
                    ),
                    _password,
                    validator: ValidateTextField.validatepassword,
                    obscure: hide),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Color(0xFF2596BE).withOpacity(0.6)),
                ),
                SizedBox(height: 50),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(height: 46, width: 400),
                  child: ElevatedButton(
                    onPressed: () {
                      //////////////////////////////////////////////////////////////////////////////////////////////////
                      setState(() {
                        //alertBox();
                        validate();
                      });
                    },
                    /////////////////////////////////////////////////////////////////////////////////////////////
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ButtonStyle(
                      elevation: null,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF2596BE),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //         width: 86,
                //         child: Divider(
                //           thickness: 1,
                //           color: Color(0xff707070),
                //         )),
                //     Text(
                //       '   or   ',
                //       style: TextStyle(
                //         fontSize: 18,
                //         color: Color(0xff707070),
                //       ),
                //     ),
                //     SizedBox(
                //         width: 86,
                //         child: Divider(
                //           thickness: 1,
                //           color: Color(0xff707070),
                //         ))
                //   ],
                // ),
                // SizedBox(height: 20),
                // RoundedButton(
                //     label: 'Create a New Account',
                //     onPressed: () {
                //       Navigator.pushNamed(context, SignUp.id);
                //     })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
