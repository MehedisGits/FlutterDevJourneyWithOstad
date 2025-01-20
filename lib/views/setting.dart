import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/views/profile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Setting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(ProfilePage(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: Text('Profile'))
          ],
        ),
      ),
    );
  }
}
