import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ToDoHome.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: ToDoHome(),
    );
  }

}