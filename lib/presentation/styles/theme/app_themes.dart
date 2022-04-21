import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../colors.dart';

class AppTheme {
  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance!.window.platformBrightness;

  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 24.0, color: dark),
        //scaffold text
        headline2: TextStyle(fontSize: 16.0, color: Colors.grey),
        // title, time , date and description text
        headline3: TextStyle(color: Colors.white),
        bodyText1: TextStyle(fontSize: 18.0, color: dark),

        bodyText2: TextStyle(fontSize: 14.0, color: dark),
      ),
      iconTheme: const IconThemeData(
        color: dark,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: dark,
      ),
      fontFamily: "Comfortaa",
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkThemeBackgroundColor,
      ),
      timePickerTheme: TimePickerThemeData(
          dialHandColor: darkThemeSecondColor,
          dayPeriodColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? darkThemeSecondColor
                  : Colors.white),
          dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.white
                  : darkThemeBackgroundColor),
          hourMinuteColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? darkThemeSecondColor
                  : Colors.grey.shade400),
          hourMinuteTextStyle: const TextStyle(fontSize: 28.0),
          hourMinuteTextColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateColor.resolveWith((states) => darkThemeSecondColor),
        ),
      ));

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkThemeSecondColor,
    scaffoldBackgroundColor: darkThemeBackgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: darkThemeBackgroundColor),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 24.0, color: Colors.white),
      //scaffold text
      headline2: TextStyle(fontSize: 16.0, color: Colors.grey),
      // title, time , date and description text
      headline3: TextStyle(color: dark),
      bodyText1: TextStyle(fontSize: 16.0, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
    ),
    fontFamily: "Comfortaa",
    drawerTheme: const DrawerThemeData(
      backgroundColor: darkThemeBackgroundColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkThemeSecondColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: darkThemeBackgroundColor,
      dayPeriodColor: darkThemeSecondColor,
      dayPeriodTextColor: Colors.white,
      hourMinuteShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      hourMinuteColor: darkThemeSecondColor,
      hourMinuteTextColor: Colors.white,
      hourMinuteTextStyle: const TextStyle(fontSize: 28.0),
      dialHandColor: Colors.white,
      dialBackgroundColor: darkThemeSecondColor,
      dialTextColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? darkThemeBackgroundColor
              : Colors.white),
      entryModeIconColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => darkThemeSecondColor),
      ),
    ),
  );
}
