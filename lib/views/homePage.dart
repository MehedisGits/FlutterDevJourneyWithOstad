import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controller/counterController.dart';
import 'package:getx/views/setting.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Center(
          child: Text('GetX'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CounterController>(
              builder: (controller) {
                return Text(
                  '${controller.count}',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                );
              },
            ),
            SizedBox(height: 12),

            //Navigation using GetX
            ElevatedButton(
                onPressed: () {
                  Get.to(SettingPage(), transition: Transition.fadeIn);
                },
                child: Text('Setting')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<CounterController>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
