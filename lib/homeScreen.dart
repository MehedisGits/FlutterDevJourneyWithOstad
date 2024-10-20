import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // Track the current theme mode (light, dark, or system)
  ThemeMode _themeMode = ThemeMode.system;

  // Function to toggle between light and dark themes
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
      // Hide the debug banner
      home: HomeScreen(themeMode: _themeMode, onToggleTheme: _toggleTheme),
      theme: _buildLightTheme(),
      // Light theme
      darkTheme: _buildDarkTheme(),
      // Dark theme
      themeMode: _themeMode, // Set the theme mode
    );
  }

  // Method to create the light theme
  ThemeData _buildLightTheme() {
    return ThemeData(
        primarySwatch: Colors.blue, // Primary color of the app
        brightness: Brightness.light, // Set to light brightness
        appBarTheme: const AppBarTheme(color: Colors.blue)); // App bar color
  }

  // Method to create the dark theme
  ThemeData _buildDarkTheme() {
    return ThemeData(
        primarySwatch: Colors.blueGrey, // Primary color for dark theme
        brightness: Brightness.dark, // Set to dark brightness
        appBarTheme:
            const AppBarTheme(color: Colors.blueGrey)); // App bar color
  }
}

class HomeScreen extends StatefulWidget {
  final ThemeMode themeMode; // Current theme mode
  final VoidCallback onToggleTheme; // Callback to toggle theme

  const HomeScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _firstTEController =
      TextEditingController(); // Controller for first number input
  final TextEditingController _secondTEController =
      TextEditingController(); // Controller for second number input
  String _result = ''; // Variable to hold the calculation result

  // Method to perform calculation based on the operator passed
  void _calculate(String operation) {
    // Parse the input values as doubles
    double? firstNumber = double.tryParse(_firstTEController.text);
    double? secondNumber = double.tryParse(_secondTEController.text);

    // Check if both numbers are valid
    if (firstNumber != null && secondNumber != null) {
      double calculationResult;

      // Perform the calculation based on the selected operation
      switch (operation) {
        case '+':
          calculationResult = firstNumber + secondNumber; // Addition
          break;
        case '-':
          calculationResult = firstNumber - secondNumber; // Subtraction
          break;
        case '*':
          calculationResult = firstNumber * secondNumber; // Multiplication
          break;
        case '/':
          // Check for division by zero
          if (secondNumber != 0) {
            calculationResult = firstNumber / secondNumber; // Division
          } else {
            _result = 'Cannot divide by zero'; // Error message
            setState(() {});
            return; // Exit the method if division by zero
          }
          break;
        default:
          _result = 'Invalid operation'; // Handle unexpected operations
          setState(() {});
          return; // Exit the method
      }

      // Update the result with the calculation
      _result = 'Result: $calculationResult';
    } else {
      // Handle invalid number input
      _result = 'Please enter valid numbers';
    }

    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'), // Title of the app
        actions: [
          // Toggle theme button in the app bar
          IconButton(
            onPressed: () {
              widget.onToggleTheme(); // Call the toggle theme function
            },
            icon: Icon(widget.themeMode == ThemeMode.light
                ? Icons.light_mode // Icon for light mode
                : Icons.dark_mode_outlined), // Icon for dark mode
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body
        child: Column(
          children: [
            // Text field for the first number
            TextField(
              controller: _firstTEController,
              keyboardType: TextInputType.number, // Number input keyboard
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter first number')), // Input label
            ),
            const SizedBox(height: 24),
            // Space between input fields
            // Text field for the second number
            TextField(
              controller: _secondTEController,
              keyboardType: TextInputType.number, // Number input keyboard
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter second number')), // Input label
            ),
            const SizedBox(height: 24),
            // Space between input fields
            Center(
              child: ButtonBar(
                alignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  // Operator buttons
                  TextButton(
                      onPressed: () => _calculate('+'), child: const Text('+')),
                  TextButton(
                      onPressed: () => _calculate('-'), child: const Text('-')),
                  TextButton(
                      onPressed: () => _calculate('*'), child: const Text('*')),
                  TextButton(
                      onPressed: () => _calculate('/'), child: const Text('/')),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Space below the buttons
            Text(_result, style: const TextStyle(fontSize: 20)),
            // Display result
          ],
        ),
      ),
    );
  }
}
