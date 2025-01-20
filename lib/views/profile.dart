import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/views/homePage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Back')),
            SizedBox(height: 12),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(HomePage(), transition: Transition.fade);
                },
                child: Text('Home')),
          ],
        ),
      ),
    );
  }
}
