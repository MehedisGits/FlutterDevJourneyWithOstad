import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Counter App",
      home: CounterApp(),
    );
  }
}

class CounterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CounterAppUI();
  }
}

class CounterAppUI extends State<CounterApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text('Counting Number: ${count}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
