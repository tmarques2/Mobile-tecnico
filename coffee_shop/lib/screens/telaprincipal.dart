import 'package:coffee_shop/components/produto.dart';
import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E9DA),
      appBar: AppBar(
        title: Text("Página Principal", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF6F4E37),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              "Menu",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Produto(
                  imagem:
                      "https://i.pinimg.com/1200x/e9/f8/eb/e9f8eb64771c9899f254b7d49673a9b2.jpg",
                  nome: 'Café expresso',
                  valor: '2,99',
                ),
                SizedBox(width: 20),
                Produto(
                  imagem:
                      "https://i.pinimg.com/736x/55/ab/33/55ab3372ef7251e7be6296a50b9273f5.jpg",
                  nome: "Cappuccino",
                  valor: "9,99",
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Produto(
                  imagem:
                      "https://t3.ftcdn.net/jpg/05/83/60/92/360_F_583609291_ptywKd4ctjgqihTRoV3QcMFMOK7U2U6q.jpg",
                  nome: 'Leite com café',
                  valor: '4,99',
                ),
                SizedBox(width: 20),
                Produto(
                  imagem:
                      "https://i.pinimg.com/736x/71/da/8f/71da8f0d4be78f042a023be16038897a.jpg",
                  nome: 'Frappuccino',
                  valor: '15,99',
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Produto(
                  imagem:
                      "https://www.cafescandelas.com/uploads/media_items/mocaccino-500.500.500.s.jpg",
                  nome: "Mocaccino",
                  valor: "17,99",
                ),
                SizedBox(width: 20),
                Produto(
                  imagem:
                      "https://thumbs.dreamstime.com/b/caf%C3%A9-de-macchiato-latino-em-copo-vidro-p%C3%A9-sobre-fundo-branco-cremoso-latte-com-camadas-leite-expresso-e-espuma-uma-ta%C3%A7a-alta-336229203.jpg",
                  nome: "Macchiato",
                  valor: "15,99",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
