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
  bool carregando = false;

  void fazerGet() async {
    setState(() => carregando = true);

    final response = await http.get(
      Uri.parse("https://json-server-1-qrw7.onrender.com/tasks"),
    );

    if (response.statusCode == 200) {
      final dados = jsonDecode(response.body);

      setState(() {
        resultado = dados.isNotEmpty ? dados[0]["title"] : "Sem dados";
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("GET", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 20, 54),
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 600,
            height: 300,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 122, 20, 54),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                carregando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        resultado.isEmpty
                            ? "Clique para buscar dados"
                            : resultado,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: fazerGet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 122, 20, 54),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Buscar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
