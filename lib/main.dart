import 'package:flutter/material.dart';
import 'mobile_layout.dart';
import 'tablet_layout.dart';
import 'desktop_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ResponsiveHome(),
    );
  }
}

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      return const MobileLayout();
    } else if (screenWidth <= 1024) {
      return const TabletLayout();
    } else {
      return const DesktopLayout();
    }
  }
}
