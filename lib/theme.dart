import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.lightBlue[300],
    fontFamily: 'Roboto',
    backgroundColor: Colors.white,
    accentColor: Colors.red[300],
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 25),
      bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'WorkSansMedium'),
      subtitle1: TextStyle(fontWeight: FontWeight.w500, fontSize: 19)


    ),


  );
}
