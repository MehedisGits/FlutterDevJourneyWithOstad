import 'package:flutter/material.dart';

ButtonStyle AppButtonStyle() {
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.all(16),
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    textStyle: TextStyle(color: Colors.white),
  );
}
