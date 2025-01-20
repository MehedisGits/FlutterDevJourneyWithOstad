import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx/controller/counterController.dart';
import 'package:getx/views/homePage.dart';
import 'package:getx/views/profile.dart';
import 'package:getx/views/setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'All about GetX',
      home: const HomePage(),
      initialBinding: ControllerBinder(),

      //Get Pages for Named Routing
      //Get.toNamed('/home') => Go to Home page
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/setting', page: () => SettingPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
      ],
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
  }
}
