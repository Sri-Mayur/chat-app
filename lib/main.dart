import 'package:chat_application/Config/Themes.dart';
import 'package:chat_application/Pages/Authentication/Auth.dart';
import 'package:chat_application/Pages/Room/RoomPage.dart';
import 'package:chat_application/Pages/SplashPage/SplashPage.dart';
import 'package:chat_application/Pages/WelcomeScreen/WelcomeScreen.dart';
import 'package:chat_application/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MayChat App',
      navigatorKey: Get.key, // Ensures one global key for GetX navigation
      
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/authPage': (context) => AuthPage(),
        '/splash': (context) => SplashPage(),
        '/room' : (context) => RoomPage(username: Get.arguments['username']),
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: WelcomePage(),
    );
  }
}
