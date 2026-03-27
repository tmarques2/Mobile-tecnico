import 'package:flutter/material.dart';

class Techstack extends StatelessWidget {
  final String imagePath;

  const Techstack({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        // Caso a imagem falhe
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.code, color: Colors.grey),
      ),
    );
  }
}
