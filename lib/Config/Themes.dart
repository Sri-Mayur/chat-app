import 'package:flutter/material.dart';
import 'Colors.dart';

var lightTheme = ThemeData();
var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
      primary: dPrimaryColor,
      onPrimary: dOnBackgroundColor,
      secondary: dSecondaryColor,
      surface: dBackgroundColor,
      onSurface: dOnBackgroundColor,
      primaryContainer: dContainerColor,
      onPrimaryContainer: dOnContainerColor),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 32,
        color: dPrimaryColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w800),
    headlineMedium: TextStyle(
        fontSize: 30,
        color: dOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(
        fontSize: 20,
        color: dOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500),
    labelLarge: TextStyle(
        fontSize: 15,
        color: dOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400),
    labelMedium: TextStyle(
        fontSize: 12,
        color: dOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400),
    labelSmall: TextStyle(
        fontSize: 110,
        color: dOnBackgroundColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w300),
  ),
);
