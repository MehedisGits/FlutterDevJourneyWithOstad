import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Counter App",
      home: SumApp(),
    );
  }
}

class SumApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SumAppUI();
  }
}

class SumAppUI extends State<SumApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sum App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(),
    );
  }
}
