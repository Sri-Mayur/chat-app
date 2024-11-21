import 'package:chat_application/Pages/Room/RoomPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> enterRoom() async {
    if (username.value.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Username cannot be empty',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      var userSnapshot =
          await _firestore.collection('users').doc(username.value).get();

      if (userSnapshot.exists) {
        Get.snackbar(
          'Success',
          'Welcome back, ${username.value}!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        await _firestore.collection('users').doc(username.value).set({
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          'Success',
          'User created: ${username.value}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }

      Get.to(RoomPage(username: username.value));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}

class AuthPage extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("User Authentication"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => SizedBox(
                  width: width * 0.8, // TextField takes 80% of the screen width
                  child: TextField(
                    onChanged: (value) => _controller.username.value = value,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      errorText: _controller.username.value.trim().isEmpty
                          ? 'Username cannot be empty'
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02), // Dynamic height spacing
              SizedBox(
                width: width * 0.5, // Button takes 50% of the screen width
                child: ElevatedButton(
                  onPressed: () {
                    _controller.enterRoom();
                  },
                  child: Text(
                    "Enter Room",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
