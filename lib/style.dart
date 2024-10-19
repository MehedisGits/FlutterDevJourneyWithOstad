import 'package:flutter/material.dart';

ButtonStyle AppButtonStyle() {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(20),
    backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );
}
InputDecoration AppInputDecoration(String label){
  return InputDecoration(
    border: const OutlineInputBorder(),
    label: Text(label),
    contentPadding: const EdgeInsets.all(8)
  );
}

SizedBox sizedBox50 (child){
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: Container(
      alignment: Alignment.center,
      child: child,
    ),
  );
}