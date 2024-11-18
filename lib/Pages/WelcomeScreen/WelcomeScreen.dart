import 'package:chat_application/Pages/WelcomeScreen/Widgets/SlideButton.dart'; // Ensure the correct path
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.mediaQuery.size.width;
    final screenHeight = Get.mediaQuery.size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/logo.svg",
                      height: screenHeight * 0.15, // 20% of screen height
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2% spacing
                    Text(
                      "MayChat",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.05, // 5% of screen height
                left: screenWidth * 0.05, // 5% padding from the left
                right: screenWidth * 0.05, // 5% padding from the right
              ),
              child: Slidebutton(), // Moved Slidebutton here properly
            ),
          ],
        ),
      ),
    );
  }
}
