import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [Spacer(), Text('Responsive UI')],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: const Center(
                child: Text(
                  'Basic Drawer',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
            const ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
            ),
          ],
        ),
      ),
      body: Center(
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Flutter Web The Basic',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          const SizedBox(height: 20),
          buildCustomButton(),
        ],
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
