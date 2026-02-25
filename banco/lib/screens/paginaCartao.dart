import 'package:banco/main.dart';
import 'package:flutter/material.dart';

class PaginaCartao extends StatelessWidget {
  const PaginaCartao({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(25),
              width: 750,
              height: 150,
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
                    //blurRadius = suavidade
                    //offset = posição
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Área Cartão",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Peça já seu cartão de crédito!",
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

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              width: 200,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/cartao1.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),

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
