import 'package:flutter/material.dart';

class Botaoprincipal extends StatelessWidget {
  Widget pagina;
  String texto;
  Botaoprincipal({super.key, required this.pagina, required this.texto});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        fixedSize: Size(150, 50),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pagina),
        );
      },
      child: Text(texto, style: TextStyle(fontSize: 20)),
    );
  }
}
