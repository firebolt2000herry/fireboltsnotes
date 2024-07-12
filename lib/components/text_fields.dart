// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final bool isObscured;
  final String hint;
  final controller;

  const TextFields({super.key, required this.controller, required this.hint, required this.isObscured});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: isObscured,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder:
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            ),
          focusedBorder: 
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hint,
        ),
      ),
    );
  }
}
