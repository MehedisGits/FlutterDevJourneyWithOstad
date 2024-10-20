import 'package:flutter/material.dart';
import 'package:flutter_devjourney_ostad/screens/product_list_screen.dart';

class CRUDApp extends StatefulWidget {
  const CRUDApp({super.key});

  @override
  State<CRUDApp> createState() => _CRUDAppState();
}

class _CRUDAppState extends State<CRUDApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          ProductListScreen(themeMode: _themeMode, onToggleTheme: _toggleTheme),
      themeMode: _themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      primaryColor: Colors.blue,
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        elevation: 1,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      primaryColor: Colors.blueGrey,
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: Colors.blueGrey,
        elevation: 1,
      ),
    );
  }
}
