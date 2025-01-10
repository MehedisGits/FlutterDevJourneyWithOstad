import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive UI'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Home', style: TextStyle(fontSize: 20)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Profile', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Flutter Web The Basic',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                ],
              ),
              const SizedBox(width: 50),
              buildCustomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomButton() {
    return SizedBox(
      width: 240,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          print('Button Pressed');
        },
        child: const Text(
          'Okay!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
      ),
    );
  }
}
