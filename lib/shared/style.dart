import 'package:alrwad/shared/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: lightTextColor),
    titleTextStyle: TextStyle(
        color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
    color: primaryColor,
    toolbarTextStyle: TextStyle(
      color: lightTextColor,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.grey,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      fillColor: Colors.grey,
      hoverColor: Colors.grey,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey),
      iconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      hintStyle: TextStyle(color: Colors.grey)),
  primarySwatch: Palette.kToDark,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amber,
    textTheme: ButtonTextTheme.primary,
  ),
  primaryColor: primaryColor,
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
  )),
  textTheme: const TextTheme(
      button: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      // subtitle1: TextStyle(
      //   fontSize: 17,
      //   color: Colors.red,
      // ),
      subtitle2: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
      headline2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
      caption: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      )),
  cardColor: Colors.white,
  cardTheme: const CardTheme(
    elevation: 5,
    shadowColor: Colors.grey,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 5,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true),
  toggleableActiveColor: primaryColor,
  unselectedWidgetColor: Colors.grey,
);

//////////////////////////////////////////Dark Theme /////////////////////////////////////
ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: lightTextColor),
    titleTextStyle: TextStyle(
        color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
    color: darkColor,
    toolbarTextStyle: TextStyle(
      color: lightTextColor,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.grey,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      fillColor: Colors.grey,
      hoverColor: Colors.grey,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey),
      iconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      hintStyle: TextStyle(color: Colors.grey)),
  primarySwatch: Palette.kToDark,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amber,
    textTheme: ButtonTextTheme.primary,
  ),
  scaffoldBackgroundColor: darkColor,
  primaryColor: primaryColor,
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
  )),
  textTheme: const TextTheme(
    button: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    // subtitle1: TextStyle(
    //   fontSize: 17,
    //   color: Colors.red,
    // ),
    subtitle2: TextStyle(
      fontSize: 17,
      color: primaryColor,
    ),
    bodyText1: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    headline1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    caption: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.grey,
  ),
  cardColor: Colors.black87,
  cardTheme: const CardTheme(
    elevation: 5,
    shadowColor: Colors.grey,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(86, 63, 63, 64),
      elevation: 10,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true),
  toggleableActiveColor: primaryColor,
  unselectedWidgetColor: Colors.grey,
);
