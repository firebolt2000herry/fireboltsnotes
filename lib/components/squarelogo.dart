// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SquareLogo extends StatelessWidget {
  final String src;
  final Function()? onTap;
  const SquareLogo({super.key, required this.src, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[200]),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Image.asset(
              src,
              height: 60,
            ),
          ),
        ),
      ),
    );
  }
}
