import 'package:flutter/material.dart';

ButtonStyle KButtonStyle = ButtonStyle(
  elevation: null,
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color(0xFF6A6A6C)))),
  backgroundColor: MaterialStateProperty.all<Color>(
    Color(0xFF6A6A6C),
  ),
);
// late String mobileNumber;
// late String getOTP;
const appID = 'c0f7f85ba6bc4e14b1e7c60fbfc93ceb';
