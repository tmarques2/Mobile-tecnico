import 'package:flutter/material.dart';
import '../models/instrumento_model.dart';
import '../services/carrinho_service.dart';
import '../services/favoritos_service.dart';
import 'carrinho_tela.dart';

class DetalhesTela extends StatefulWidget {
  final Instrumento instrumento;

  const DetalhesTela({Key? key, required this.instrumento}) : super(key: key);

  @override
  State<DetalhesTela> createState() => _DetalhesTelaState();
}

class _DetalhesTelaState extends State<DetalhesTela> {
  @override
  Widget build(BuildContext context) {
    // Como agora é StatefulWidget, acessamos o instrumento usando "widget.instrumento"
    double precoAVista = widget.instrumento.preco * 0.9;

    // Verifica no Singleton se este item já é um favorito
    bool isFav = FavoritosService().isFavorito(widget.instrumento);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text("Detalhes do Produto"),
        actions: [
          // Botão de Favoritar no topo da tela
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                FavoritosService().alternarFavorito(widget.instrumento);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFav
                        ? "Removido dos favoritos"
                        : "Adicionado aos favoritos!",
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.instrumento.imagemUrl,
                height: 260,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.instrumento.nome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Container do Bloco de Preço
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF1E1E1E),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "R\$ ${precoAVista.toStringAsFixed(2)} Pix / Boleto",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE5A93C),
                    ),
                  ),
                  const Text(
                    "com 10% de desconto",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "ou R\$ ${widget.instrumento.preco.toStringAsFixed(2)} em até 4x no cartão",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Botão Comprar Integrado ao Carrinho
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C6B3F), // Verde Sucesso
                ),
                onPressed: () {
                  // 1. Adiciona o produto na classe Singleton do Carrinho
                  CarrinhoService().adicionar(widget.instrumento);

                  // 2. Navega automaticamente para a tela do carrinho
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarrinhoTela(),
                    ),
                  );
                },
                child: const Text(
                  "Adicionar ao Carrinho",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
