import 'dart:convert';
import 'package:find_friend/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'VIP_member_detail.dart';

class Verification extends StatelessWidget {
  static String id = 'verification';
  late String userid;
  Verification(this.userid);
  var retimage;
  late String check;

  Future _getpostImage(ImageSource source, String userid) async {
    print('getpost called');
    var image = await ImagePicker.platform.pickImage(source: source);
    retimage = image;
    return retimage;
  }

  Future _submitpost(PickedFile? image, BuildContext context) async {
    print('submit post called');
    if (image != null) {
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "http://findfriend.notionprojects.tech/api/verification.php"));
      request.fields['user_id'] = userid;
      request.fields['token'] = '123456789';
      var pic =
          await http.MultipartFile.fromPath("verification_image", image.path);
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('----------------------------------------');
      print(responseString);
      var Response = jsonDecode(responseString);
      check = Response['message'];
      // Status:True,  Message: Waiting for confirmation and push
      if (Response['status']) {
        final snackbar = SnackBar(
            duration: Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content:
                Text('${Response['message']}', textAlign: TextAlign.center));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VIPMemberDetail(userid)));
      }
      // Status:False , --------------------------------
      else {
        // Message:You Are Already Vip User
        if (check == 'You Are Already Vip User') {
          final snackbar = SnackBar(
              duration: Duration(milliseconds: 1000),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content:
                  Text('${Response['message']}', textAlign: TextAlign.center));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => GeneralPage(userid)));
        }
        // Message:Already Applied For Vip User & navigate to Vip member detail
        else {
          final snackbar = SnackBar(
              duration: Duration(milliseconds: 1000),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content:
                  Text('${Response['message']}', textAlign: TextAlign.center));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => VIPMemberDetail(userid)));
        }
      }
    }
    // Image= NULL
    else {
      final snackbar = SnackBar(
          duration: Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Please Select Image'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Verification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                _getpostImage(ImageSource.gallery, userid);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.camera_alt,
                          color: Colors.white.withOpacity(0.6), size: 40),
                      Text(
                        'Upload Images',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 14),
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
            Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(height: 46, width: 400),
                    child: ElevatedButton(
                      onPressed: () {
                        print('submit pressed');
                        _submitpost(retimage, context);
                      },
                      child: Text(
                        'Submit',
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
                  RoundedButton(
                      label: 'Became Our VIP Member ?',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VIPMemberDetail(userid)));

                        //Navigator.pushNamed(context, VIPMemberDetail.id);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// if (check == 'You Are Already Vip User') {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => GeneralPage(userid)));
//}
