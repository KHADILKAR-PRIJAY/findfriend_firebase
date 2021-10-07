import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  VoidCallback onPressed;
  final double width;
  final double height;
  RoundedButton(
      {required this.label,
      required this.onPressed,
      this.width = 400,
      this.height = 46});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: height, width: width),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: Color(0xFF2596BE), fontSize: 18),
        ),
        style: ButtonStyle(
          elevation: null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.black))),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xFFE7F3FF),
          ),
        ),
      ),
    );
  }
}
