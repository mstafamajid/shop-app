import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

ThemeData Mytheme(BuildContext context) {
  return ThemeData(
    fontFamily: 'lato',
    canvasColor: Color(0xffF9F5EB),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Color(0xff1C3879),
          secondary: Color(0xff607EAA),
        ),
    textTheme: const TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Color(0xffEAE3D2)),
        bodyText2: TextStyle(color: Colors.red)),
  );
}
