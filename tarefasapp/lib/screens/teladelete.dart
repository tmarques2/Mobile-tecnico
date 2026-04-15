import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaDelete extends StatefulWidget {
  const TelaDelete({super.key});

  @override
  State<TelaDelete> createState() => _TelaDeleteState();
}

class _TelaDeleteState extends State<TelaDelete> {
  List listaApi = [];

  @override //garante que o estado inicial sempre reinicie
  void initState() {
    // serve para rodar uma função ao abrir uma tela
    super.initState(); // garante que vai funcionar no estado inicial
    fazerGet();
  }

  void fazerGet() async {
    final respostaServidor = await http.get(
      Uri.parse("http://10.109.72.27:3000/tasks"),
    );
    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(respostaServidor.body);
      setState(() {
        listaApi = dados;
      });
    }
  }

  void fazerDelete(final id) async {
    final respostaServidor = await http.delete(
      Uri.parse("http://10.109.72.27:3000/tasks/$id"),
    );
    if (respostaServidor.statusCode == 200) {
      fazerGet(); //atualizo a minha tela
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Dado deletado com sucesso")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Delete")),
      body: ListView(
        //permite a rolagem da tela
        children: [
          for (final item in listaApi)
            Card(
              child: ListTile(
                leading: Text(item["title"] ?? "Sem título"),
                trailing: GestureDetector(
                  onTap: () => fazerDelete(item["id"]),
                  child: Icon(Icons.delete),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
