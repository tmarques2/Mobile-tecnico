import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaPost extends StatefulWidget {
  const TelaPost({super.key});

  @override
  State<TelaPost> createState() => _TelaPostState();
}

class _TelaPostState extends State<TelaPost> {
  TextEditingController controller = TextEditingController();
  bool carregando = false;

  void fazerPost() async {
    if (controller.text.isEmpty) return;

    setState(() => carregando = true);

    final response = await http.post(
      Uri.parse("https://json-server-1-qrw7.onrender.com/tasks"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": controller.text}),
    );

    setState(() => carregando = false);

    if (response.statusCode == 201) {
      controller.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Adicionado com sucesso")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("POST", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 20, 54),
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 122, 20, 54),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Digite algo",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, // ocupa toda a largura
                  height: 55, // altura maior
                  child: ElevatedButton(
                    onPressed: carregando ? null : fazerPost,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: carregando
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Enviar",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 122, 20, 54),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
