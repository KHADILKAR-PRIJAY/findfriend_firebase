import 'package:flutter/material.dart';

class EnterFieldWithout extends StatelessWidget {
  final String hintText;
  //final ValueChanged<String> onChanged;
  final Widget icon;
  bool readonly;
  TextEditingController controller;
  EnterFieldWithout(this.hintText, this.controller,
      {this.icon = const SizedBox(), this.readonly = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      child: TextFormField(
        readOnly: readonly,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: icon,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          // labelText: labelText,
          // labelStyle: new TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
