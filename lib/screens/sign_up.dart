import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/screens/Validator/validators.dart';
import 'package:flutter/material.dart';
import 'package:find_friend/components/enter_field.dart';
import 'package:find_friend/components/logo.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'log_in.dart';

const String url = 'http://findfriend.notionprojects.tech/api/signup.php';

class SignUp extends StatefulWidget {
  static String id = 'sign_up';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _fullName = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _birthdate = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = DatabaseMethods();

  void validate() {
    if (_formkey.currentState!.validate()) {
      print('validate');
      alertBox();
    } else {
      print('not validated');
    }
  }

  String Day = "DD";
  String Month = "MM";
  String Year = "YYYY";
  DateTime currentDate = DateTime.now();

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
        _birthdate.text =
            '${Year.toString()}-${Month.toString()}-${Day.toString()}';
      });
  }

  var _value = 1;
  late bool agree = false;

  Future<void> postSignUp(String userid) async {
    var response = await http.post(Uri.parse(url), body: {
      'token': '123456789',
      'user_id': userid,
      'full_name': '${_fullName.text.toString()}',
      'gender': (_value == 2) ? 'f' : 'm',
      'username': '${_userName.text.toString()}',
      'password': '${_password.text.toString()}',
      'confirm_password': '${_confirmPassword.text.toString()}',
      'email': '${_email.text.toString()}',
      'birthday': '${_birthdate.text}'
    });
    print('${Year.toString()}-${Month.toString()}-${Day.toString()}');
    print('Sign_up id: ' + userid);
    if (response.statusCode == 200) {
      Map<String, String> userInfoMap = {
        'name': _userName.text,
        'id': userid,
        'profile':
            'https://findfriend.notionprojects.tech/upload/profile/no_image.jpg'
      };
      await databaseMethods.uploadUserInfo(userInfoMap, userid);
      Navigator.pushNamed(context, LogIn.id);
      _fullName.clear();
      _userName.clear();
      _password.clear();
      _confirmPassword.clear();
    }
    print(response.body);
    print(_fullName.text.toString());
  }

  void alertBox() {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    showDialog(
        barrierColor: Colors.black,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey,
              contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 1),
              titlePadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Reminder',
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
                height: 299,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          'Please observe there terms when you submit You Content:\n\n'
                          ' You are prohibited from posting and agree not to post any objectionable content which includes, but is not limited to : Sexually Explicit Material, Violence and Bullying, hate Speech, Sensitive Event, illegal Activity, and intellectual Property Infringement. Should you violate the Terms, your account will be suspended.\n\n'
                          ' If you spot any violations, please inform us using the Repory System built in our app. any convicted violators shall be banned immediately. \n\n'
                          'for more detailed information, please refer to findfriend ',
                      style: TextStyle(fontSize: 12),
                    ),
                    TextSpan(
                        text: 'Terms of Use.',
                        style: TextStyle(
                            color: Color(0xff2596BE),
                            decoration: TextDecoration.underline))
                  ], style: TextStyle(color: Color(0xffF0EEEF))),
                ),
              ),
              actionsPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              actions: [
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                          onPressed: () {
                            agree = false;
                            Navigator.pop(context);
                            alertBox2();
                          },
                          child: Text(
                            'Refuse',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 40,
                        width: 102,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                            onPressed: () {
                              agree = true;
                              postSignUp('${arguments['example']}');
                            },
                            child: Text(
                              'Agree',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    )
                  ],
                )
              ],
            ));
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
                      'Reminder',
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
                height: 299,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Allow access to the following permission for better services.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(height: 46, width: 400),
                      child: ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            SizedBox(width: 40),
                            Text(
                              'Call',
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
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.mic_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(width: 40),
                            Text(
                              'Microphone',
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
              actionsPadding: EdgeInsets.all(10),
              buttonPadding: EdgeInsets.zero,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                            onPressed: () {
                              agree = true;
                              //postLogIn();
                            },
                            child: Text(
                              'Allow All',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    )
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //print('sign_up_sc id:' + arguments['example']);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 15),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Logo(),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  SizedBox(height: 10),
                  EnterField(
                      'Enter Full Name',
                      'Full Name',
                      Container(
                        width: 0,
                        height: 0,
                      ),
                      _fullName,
                      validator: ValidateTextField.validateNull),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Select Gender ',
                          // textAlign: TextAlign.left,
                        ),
                      ),
                      Text('*', style: TextStyle(color: Colors.red))
                    ],
                  ),
                  DropdownButton(
                    underline: Container(color: Colors.white, height: 1),
                    dropdownColor: Color(0xFF1E1E1E),
                    isExpanded: true,
                    isDense: true,
                    value: _value,
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "Male",
                          style: TextStyle(color: Colors.grey),
                        ),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "Female",
                          style: TextStyle(color: Colors.grey),
                        ),
                        value: 2,
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  EnterField(
                      'Enter Username',
                      'Username',
                      Container(
                        width: 0,
                        height: 0,
                      ),
                      _userName),
                  EnterField(
                    '${Year}-${Month}-${Day}',
                    'Birthday',
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_today,
                          color: Colors.white, size: 20),
                    ),
                    _birthdate,
                    readonly: true,
                    showcursor: false,
                  ),
                  EnterField(
                      'Enter Email',
                      'Email',
                      Container(
                        width: 0,
                        height: 0,
                      ),
                      _email,
                      textInputType: TextInputType.emailAddress),
                  // Container(
                  //   child: Text(
                  //     'Birthdate',
                  //     // textAlign: TextAlign.left,
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       child: Text('${Day}-${Month}-${Year}',
                  //           style: TextStyle(color: Colors.grey)
                  //           // textAlign: TextAlign.left,
                  //           ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         _selectDate(context);
                  //       },
                  //       child: Icon(
                  //         Icons.calendar_today,
                  //         color: Colors.white,
                  //         size: 14,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: Divider(thickness: 1, color: Colors.white),
                  // ),
                  EnterField(
                      'Enter Password',
                      'Password',
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                      ),
                      _password,
                      maxLength: 6,
                      textInputType: TextInputType.number,
                      validator: ValidateTextField.validatepassword),
                  EnterField(
                      'Re-enter Password',
                      ' Confirm Password',
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                      ),
                      _confirmPassword,
                      textInputType: TextInputType.number,
                      maxLength: 6,
                      validator: ValidateTextField.validatepassword),
                  SizedBox(
                    height: 40,
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(height: 46, width: 400),
                    child: ElevatedButton(
                      onPressed: () {
                        validate();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ButtonStyle(
                        elevation: null,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have already an account?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        ' Sign-in',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
