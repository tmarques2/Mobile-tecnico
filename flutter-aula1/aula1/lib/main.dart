// BIBLIOTECA QUE IMPORTA OS COMPONENTES DO FLUTTER
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(TelaInicial());
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //tira a fitinha de debug
      //material app prove componentes para a sua tela
      home: Scaffold(
        //divide a tela em ate 3 partes
        appBar: AppBar(
          title: Text(
            "Tela inicial app 1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Arial",
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(255, 117, 19, 137),
        ),
        body: Column(
          spacing: 30, //espacamento
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(width: 50, height: 50, color: Colors.yellow),
            Container(width: 50, height: 50, color: Colors.pink),
            Row(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(width: 50, height: 50, color: Colors.blue),
                Container(width: 50, height: 50, color: Colors.yellow),
                Container(width: 50, height: 50, color: Colors.pink),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
