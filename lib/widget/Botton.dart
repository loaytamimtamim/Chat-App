import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Botton extends StatelessWidget {
  Botton({required this.nameBotton, required this.onTap});
  String nameBotton;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        child: Center(
          child: Text(
            nameBotton,
            style: TextStyle(fontSize: 20),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
