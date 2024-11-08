import 'package:chat_application/Config/Themes.dart';
import 'package:chat_application/Pages/SplashPage/SplashPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'May Chat',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: SplashPage(),
    );
  }
}
