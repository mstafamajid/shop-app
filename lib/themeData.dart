import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

//const Color(0xff1C3879)
//const Color(0xffF9F5EB)
ThemeData Mytheme(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: const Color(0xff6db9fc),
          fontWeight: FontWeight.w900,
          fontSize: 30,
        ),
        elevation: 0,
        backgroundColor: const Color(0xffeff7ff),
        foregroundColor: const Color(0xff6db9fc)),
    dialogTheme: const DialogTheme(
      titleTextStyle:
          TextStyle(fontSize: 22, color: Colors.red, fontFamily: 'lato'),
      contentTextStyle:
          TextStyle(fontSize: 17, color: Colors.black87, fontFamily: 'lato'),
    ),
    listTileTheme: const ListTileThemeData(iconColor: const Color(0xff6db9fc)),
    fontFamily: 'lato',
    canvasColor: const Color(0xffeff7ff),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0xff6db9fc),
          secondary: const Color(0xff50a6f0),
        ),
    textTheme: const TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Color(0xffffffff)),
        bodyText2: TextStyle(color: Color(0xff607EAA))),
  );
}
