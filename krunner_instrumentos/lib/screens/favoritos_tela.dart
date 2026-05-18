import 'package:flutter/material.dart';
import '../services/favoritos_service.dart';
import '../components/instrumento_card.dart';

class FavoritosTela extends StatefulWidget {
  const FavoritosTela({Key? key}) : super(key: key);

  @override
  State<FavoritosTela> createState() => _FavoritosTelaState();
}

class _FavoritosTelaState extends State<FavoritosTela> {
  final FavoritosService _favoritos = FavoritosService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Favoritos", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF121212),
      ),
      body: _favoritos.favoritos.isEmpty
          ? const Center(
              child: Text("Você ainda não favoritou nenhum produto.", style: TextStyle(color: Colors.grey)),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _favoritos.favoritos.length,
              itemBuilder: (context, index) {
                final item = _favoritos.favoritos[index];
                return InstrumentoCard(
                  instrumento: item,
                  favoritado: true,
                  onFavoritoPressed: () {
                    setState(() {
                      _favoritos.alternarFavorito(item);
                    });
                  },
                  onAdicionarPressed: () {
                    // Lógica para adicionar o item favorito ao carrinho
                    print('Adicionado ao carrinho pelos favoritos!');
                  },
                  onTap: () {},
                );
              },
            ),
    );
  }
}