import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLocal extends StatefulWidget {
  const TelaLocal({super.key});

  @override
  State<TelaLocal> createState() => _TelaLocalState();
}

class _TelaLocalState extends State<TelaLocal> {
  List<String> items = [];
  TextEditingController valorDigitado = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final dados = await SharedPreferences.getInstance();
    setState(() {
      items = dados.getStringList('nomes') ?? [];
    });
  }

  void criarDados() async {
    final dados = await SharedPreferences.getInstance();
    setState(() {
      items.add(valorDigitado.text);
      valorDigitado.clear();
    });

    await dados.setStringList('nomes', items);
  }

  void deletarDados(int index) async {
    final dados = await SharedPreferences.getInstance();
    setState(() {
      items.removeAt(index);
    });

    await dados.setStringList('nomes', items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("LOCAL", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 20, 54),
        automaticallyImplyLeading: false,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// INPUT
          TextField(
            controller: valorDigitado,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Digite um valor",
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// BOTÃO
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: criarDados,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 122, 20, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Criar dado",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// LISTA
          for (int i = 0; i < items.length; i++)
            Container(
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
                      items[i],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () => deletarDados(i),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
