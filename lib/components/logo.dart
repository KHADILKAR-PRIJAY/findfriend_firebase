import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final String assetName = 'assets/images/logo_transparent.svg';
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo', height: 90),
    );
  }
}
