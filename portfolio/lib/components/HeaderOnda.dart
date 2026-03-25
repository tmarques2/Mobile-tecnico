import 'package:flutter/material.dart';
import 'OndaClipper.dart';

class HeaderOnda extends StatelessWidget {
  final String titulo;
  final bool mostrarBotaoVoltar;

  const HeaderOnda({
    super.key,
    required this.titulo,
    this.mostrarBotaoVoltar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: OndaClipper(),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF531B24), Color(0xFF6A2931)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Text(
            titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        if (mostrarBotaoVoltar)
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
      ],
    );
  }
}
