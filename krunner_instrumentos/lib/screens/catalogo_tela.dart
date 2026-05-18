import 'package:flutter/material.dart';
import '../components/instrumento_card.dart';
import '../models/instrumento_model.dart';
import '../services/api_service.dart';
import '../services/carrinho_service.dart';
import '../services/favoritos_service.dart';
import 'detalhes_tela.dart';
import 'carrinho_tela.dart';
import 'favoritos_tela.dart';
import 'home_tela.dart';

class CatalogoTela extends StatefulWidget {
  final String categoria;

  const CatalogoTela({Key? key, this.categoria = "Todos"}) : super(key: key);

  @override
  State<CatalogoTela> createState() => _CatalogoTelaState();
}

class _CatalogoTelaState extends State<CatalogoTela> {
  final ApiService _apiService = ApiService();
  late String _categoriaSelecionada;

  // Lista com todas as categorias oficiais da loja Krunner
  final List<String> _categorias = [
    "Todos",
    "Cordas",
    "Sopro",
    "Percussão",
    "Teclas",
  ];

  @override
  void initState() {
    super.initState();
    _categoriaSelecionada = widget.categoria;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: Image.asset(
          'images/logo.png',
          height: 45,
          errorBuilder: (_, error, stackTrace) => const Text(
            "KRUNNER",
            style: TextStyle(
              color: Color(0xFFE5A93C),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          // Lupa (Pesquisa)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    BuscaInstrumentoDelegate(), // Usa a classe que criamos na Home
              );
            },
          ),
          // Favoritos
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritosTela()),
              );
            },
          ),
          // Carrinho
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CarrinhoTela()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // FILTRO DE CATEGORIAS (Fila Horizontal Rolável de ChoiceChips)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final cat = _categorias[index];
                final bool isSelected =
                    _categoriaSelecionada.toLowerCase() == cat.toLowerCase();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(
                      0xFFE5A93C,
                    ), // Amarelo Identidade Krunner
                    backgroundColor: const Color(0xFF1E1E1E),
                    onSelected: (bool selected) {
                      setState(() {
                        _categoriaSelecionada = selected ? cat : "Todos";
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // LISTAGEM EM GRID CONECTADA DIRETAMENTE AO JSON SERVER
          Expanded(
            child: FutureBuilder<List<Instrumento>>(
              future: _apiService
                  .buscarTodos(), // Requisição assíncrona HTTP GET
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFE5A93C)),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Erro ao carregar dados do JSON Server."),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhum instrumento cadastrado no banco de dados.",
                    ),
                  );
                }

                final todosProdutos = snapshot.data!;

                // Lógica de filtragem baseada na pílula ativa
                final produtosFiltrados = _categoriaSelecionada == "Todos"
                    ? todosProdutos
                    : todosProdutos
                          .where(
                            (p) =>
                                p.categoria.toLowerCase() ==
                                _categoriaSelecionada.toLowerCase(),
                          )
                          .toList();

                if (produtosFiltrados.isEmpty) {
                  return Center(
                    child: Text(
                      "Nenhum produto em '$_categoriaSelecionada'.",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: produtosFiltrados.length,
                  itemBuilder: (context, index) {
                    final item = produtosFiltrados[index];

                    // Verifica no Singleton se o item é favorito
                    bool isFav = FavoritosService().isFavorito(item);

                    return InstrumentoCard(
                      instrumento: item,
                      favoritado: isFav, // recebe a variável real
                      onFavoritoPressed: () {
                        // Quando clica, altera no serviço e atualiza a tela
                        setState(() {
                          FavoritosService().alternarFavorito(item);
                        });

                        ScaffoldMessenger.of(context).clearSnackBars();
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetalhesTela(instrumento: item),
                          ),
                        );
                      },
                      onAdicionarPressed: () {
                        CarrinhoService().adicionar(item);

                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Adicionado ao carrinho!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
