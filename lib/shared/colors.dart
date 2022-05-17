import 'package:flutter/material.dart';

// const primaryColor = Color.fromRGBO(220, 118, 51, 1);
const primaryColor = Color.fromRGBO(242, 144, 36, 1);
const buttonColor = Colors.deepOrange;
const lightTextColor = Colors.white;
const darkColor = Color.fromARGB(4, 41, 58, 1);
const darkColor2 = Color.fromARGB(6, 70, 99, 1);
// const darkColor = Color.fromARGB(236, 179, 101, 1);

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xfff29024, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffce5641), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color.fromRGBO(220, 118, 51, 1), //90%
      900: Color.fromRGBO(220, 118, 51, 1), //100%
    },
  );
} // you can define define int 500 as the default shade and ad
