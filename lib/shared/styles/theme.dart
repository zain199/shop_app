import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
    textTheme:  TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
    ),
    primarySwatch: defColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 5.0,
        selectedItemColor: defColor,
        unselectedItemColor: Colors.black,
        type:BottomNavigationBarType.fixed
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      actionsIconTheme: IconThemeData(
          color: Colors.black,
          size: 35.0
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,


      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0.0,
      color: Colors.white,
    )
);

ThemeData darkTheme = ThemeData(
    textTheme:  TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
    ),
    primarySwatch: defColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 5.0,
      selectedItemColor: defColor,
      unselectedItemColor: Colors.grey,
      type:BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[900],
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 35.0
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,


      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:Colors.grey[900],
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0.0,
      color: Colors.grey[900],
    )
);
