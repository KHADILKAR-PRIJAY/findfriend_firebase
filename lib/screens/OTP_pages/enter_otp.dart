import 'dart:convert';
import 'package:find_friend/screens/log_in.dart';
import 'package:find_friend/screens/sign_up.dart';
import 'package:find_friend/services/fcm_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:find_friend/components/logo.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;

const String url = 'http://findfriend.notionprojects.tech/api/otp_verifiy.php';

class EnterOtp extends StatefulWidget {
  static String id = 'enter_otp';
  final String userid;
  final String phonenumber;
  final bool verify;
  EnterOtp(
      {required this.userid, required this.phonenumber, required this.verify});

  @override
  _EnterOtpState createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  TextEditingController _OTP = TextEditingController();
  late FirebaseMessaging _getfcmtoken;

  @override
  void initState() {
    _getfcmtoken = FirebaseMessaging.instance;

    _getfcmtoken.getToken().then((value) {
      print('my fcm:' + value.toString());
      Fcm_Services().sendfcm(widget.userid, value!);
    });

    super.initState();
  }

  Future<void> postOTPNumber() async {
    print('Phone number' + widget.phonenumber);
    var Response = await http.post(
      Uri.parse(url),
      body: {
        'token': '123456789',
        'mobile_number': widget.phonenumber,
        'otp': '${_OTP.text.toString()}'
      },
    );
    var response = jsonDecode(Response.body);
    if (response['status']) {
      if (widget.verify) {
        Navigator.pushNamed(context, SignUp.id,
            arguments: {'example': widget.userid.toString()});
        // _OTP.clear();
      } else {
        Navigator.pushNamed(context, LogIn.id);
        //_OTP.clear();
      }
    } else {
      final snackbar = SnackBar(
          duration: Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(response['message'], textAlign: TextAlign.center));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    print(Response.body);
    print(_OTP.text);
  }

  @override
  Widget build(BuildContext context) {
    print('enter_otp_sc id:' + widget.userid);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Logo(),
              Center(
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Enter OTP',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                child: PinFieldAutoFill(
                  controller: _OTP,
                  // onCodeSubmitted: (value) {
                  //   setState(() {
                  //     //value = _OTP.text.toString();
                  //     _OTP = value as TextEditingController;
                  //     print(_OTP);
                  //   });
                  // },
                  decoration: UnderlineDecoration(
                      colorBuilder: FixedColorBuilder(Colors.white),
                      textStyle: TextStyle(color: Colors.white)),
                  codeLength: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Enter 6 digit number',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 30),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: 46, width: 400),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      postOTPNumber();
                    });
                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
