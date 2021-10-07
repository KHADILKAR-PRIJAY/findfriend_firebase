import 'package:flutter/material.dart';

class DrawerButton extends StatefulWidget {
  final String label;
  final IconData icon;
  VoidCallback onPressed;
  DrawerButton(this.label, this.icon, this.onPressed);

  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 46, width: 400),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Icon(widget.icon, color: Colors.white),
            SizedBox(width: 40),
            Text(
              widget.label,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18),
            ),
          ],
        ),
        style: ButtonStyle(
          elevation: null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.black))),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(0xff000000),
          ),
        ),
      ),
    );
  }
}
