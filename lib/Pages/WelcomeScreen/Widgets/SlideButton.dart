import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart'; // Ensure this is added
import 'package:get/get.dart';

class Slidebutton extends StatelessWidget {
  const Slidebutton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return SizedBox(
      width: screenWidth * 0.8, // 80% of screen width
      height: 50,
      child: SlideAction(
        onSubmit: () {
          Get.offNamed("/authPage");
        },
        text: "Slide to Start",
        textColor: Colors.grey[600], // Greyish text color
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        innerColor: Theme.of(context).colorScheme.primary, // Use primary color
        outerColor: Theme.of(context).colorScheme.primaryContainer,
        sliderButtonIconSize: 20,
      ),
    );
  }
}
