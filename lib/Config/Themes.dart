import 'package:flutter/material.dart';
import 'Colors.dart';

var lightTheme = ThemeData();
var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
      primary: dPrimaryColor,
      onPrimary: dlOnBackgroundColor,
      surface: dBackgroundColor,
      onSurface: dOnContainerColor,
      primaryContainer: dContainerColor,
      onPrimaryContainer: dOnContainerColor),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32,
        color: dPrimaryColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w800),
    headlineMedium: TextStyle(
        fontSize: 32,
        color: dlOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(
        fontSize: 32,
        color: dPrimaryColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600),
  ),
);
