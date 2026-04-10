import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaGet extends StatefulWidget {
  const TelaGet({super.key});

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  String resultado = "";

  void fazerGet() async {
    final respostaServidor = await http.get(
      Uri.parse("http://10.109.72.26:3000/tasks"),
    );

    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(respostaServidor.body);

      setState(() {
        resultado = dados[0]["title"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Tela Get", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          children: [
            Text(resultado, style: TextStyle(fontFamily: 'Montserrat')),
            TextButton(onPressed: fazerGet, child: Text("Fazer Get")),
          ],
        ),
      ),
    );
  }
}
