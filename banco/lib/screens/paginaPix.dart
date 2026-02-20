import 'package:banco/main.dart';
import 'package:flutter/material.dart';

class PaginaPix extends StatelessWidget {
  const PaginaPix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: const Text(
          "Pix",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Card principal
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 117, 19, 137),
                    Colors.deepPurple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.deepPurple,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Área Pix",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Envie e receba dinheiro\nem segundos 💸",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Botões principais
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _botaoPix(Icons.qr_code, "Pagar"),
                _botaoPix(Icons.send, "Enviar"),
                _botaoPix(Icons.call_received, "Receber"),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 Minhas chaves
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Minhas Chaves Pix",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.deepPurple),
                    title: Text("thainara@email.com"),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.deepPurple),
                    title: Text("(11) 99999-0000"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Últimos Pix
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Últimos Pix",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.arrow_upward, color: Colors.red),
                    title: Text("Pix enviado"),
                    trailing: Text("- R\$ 200,00"),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_downward, color: Colors.green),
                    title: Text("Pix recebido"),
                    trailing: Text("+ R\$ 500,00"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Botão voltar
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaInicial()),
                );
              },
              child: const Text(
                "Voltar ao início",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Botão redondo estilo banco
  Widget _botaoPix(IconData icon, String texto) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.deepPurple, size: 30),
        ),
        const SizedBox(height: 8),
        Text(texto, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
