import 'package:banco/main.dart';
import 'package:flutter/material.dart';

class PaginaEmprestimo extends StatelessWidget {
  const PaginaEmprestimo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ThaBank",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 117, 19, 137),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                //funcao para navegar para outra pagina
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaInicial()),
                );
              },
              child: Text("Inicio"),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
