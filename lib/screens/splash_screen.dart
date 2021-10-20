import 'package:find_friend/firebase_notification_handler/notification_handler.dart';
import 'package:find_friend/screens/OTP_pages/generate_otp.dart';
import 'package:flutter/material.dart';
import 'package:find_friend/components/logo.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, GenerateOtp.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(child: Logo()),
    );
  }
}
