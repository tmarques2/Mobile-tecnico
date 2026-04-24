import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaPut extends StatefulWidget {
  const TelaPut({super.key});

  @override
  State<TelaPut> createState() => _TelaPutState();
}

class _TelaPutState extends State<TelaPut> {
  List listaApi = [];
  List<TextEditingController> controladores = [];

  @override
  void initState() {
    super.initState();
    fazerGet();
  }

  void fazerGet() async {
    final respostaServidor = await http.get(
      Uri.parse("https://json-server-1-qrw7.onrender.com/tasks"),
    );

    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(respostaServidor.body);

      setState(() {
        listaApi = dados;

        controladores.clear();
        for (final item in listaApi) {
          controladores.add(TextEditingController(text: item["title"]));
        }
      });
    }
  }

  void fazerPut(final id, final index) async {
    final respostaServidor = await http.patch(
      Uri.parse("https://json-server-1-qrw7.onrender.com/tasks/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": controladores[index].text}),
    );

    if (respostaServidor.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Dado atualizado com sucesso"),
          backgroundColor: Color.fromARGB(255, 122, 20, 54),
        ),
      );

      fazerGet();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao atualizar"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("EDITAR", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 20, 54),
        automaticallyImplyLeading: false,
      ),

      body: listaApi.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 122, 20, 54),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (int i = 0; i < listaApi.length; i++)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 122, 20, 54),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listaApi[i]["title"] ?? "Sem título",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: controladores[i],
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Editar título",
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => fazerPut(listaApi[i]["id"], i),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    "Você chegou ao final da lista :)",
                    style: TextStyle(color: Color.fromARGB(255, 122, 20, 54)),
                  ),
                ),
              ],
            ),
    );
  }
}
