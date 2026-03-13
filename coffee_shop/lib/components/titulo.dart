import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  const Titulo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Coffee Shop",
      style: TextStyle(
        fontSize: 30,
        color: Colors.brown,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}
