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
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    fazerGet();
  }

  void fazerGet() async {
    final response = await http.get(
      Uri.parse("https://json-server-1-qrw7.onrender.com/tasks"),
    );

    if (response.statusCode == 200) {
      setState(() {
        listaApi = jsonDecode(response.body);
        carregando = false;
      });
    }
  }

  void fazerDelete(id) async {
    final response = await http.delete(
      Uri.parse("https://json-server-1-qrw7.onrender.com/tasks/$id"),
    );

    if (response.statusCode == 200) {
      fazerGet();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Deletado com sucesso")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("DELETE", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 20, 54),
        automaticallyImplyLeading: false,
      ),

      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listaApi.length,
              itemBuilder: (context, index) {
                final item = listaApi[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 122, 20, 54),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () => fazerDelete(item["id"]),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
