import 'dart:convert';
import 'package:find_friend/firebase_notification_handler/notification_handler.dart';
import 'package:find_friend/screens/OTP_pages/enter_otp.dart';
import 'package:find_friend/screens/Validator/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_friend/components/enter_field.dart';
import 'package:find_friend/components/logo.dart';
import 'package:http/http.dart' as http;

const String url =
    'http://findfriend.notionprojects.tech/api/login_with_mobile.php';

class GenerateOtp extends StatefulWidget {
  static String id = 'generate_otp';

  @override
  _GenerateOtpState createState() => _GenerateOtpState();
}

class _GenerateOtpState extends State<GenerateOtp> {
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _demo = TextEditingController();
  late String phoneNumber;
  var _formkey = GlobalKey<FormState>();

  Future<void> postMobileNumber() async {
    print(_mobileNumber.text.toString());
    phoneNumber = _mobileNumber.text.toString();
    var Response = await http.post(
      Uri.parse(url),
      body: {'token': '123456789', 'mobile_number': '${_mobileNumber.text}'},
    );
    var response = jsonDecode(Response.body);
    bool verify = response['status'];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnterOtp(
                  userid: response['data']['user_id'],
                  phonenumber: phoneNumber,
                  verify: verify,
                )));
    print(response);
    print(_mobileNumber.toString());
  }

  void validate() {
    if (_formkey.currentState!.validate()) {
      print('validate');
      postMobileNumber();
    } else {
      print('not validated');
    }
  }

  @override
  void initState() {
    FirebaseNotifications().setupFirebase(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Logo(),
                Text(
                  'Log In',
                  style: TextStyle(fontSize: 35),
                ),
                EnterField(
                    'Mobile Number',
                    'Enter Mobile Number',
                    Container(
                      height: 0,
                      width: 0,
                    ),
                    _mobileNumber,
                    textInputType: TextInputType.phone,
                    validator: ValidateTextField.validatephone,
                    maxLength: 10),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(height: 46, width: 400),
                  child: ElevatedButton(
                    onPressed: () {
                      validate();
                    },
                    //validate,
                    child: Text(
                      'Generate OTP',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
