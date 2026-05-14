import 'package:flutter/material.dart';
import '../components/banner_carrossel.dart';
import '../components/instrumento_card.dart';
import '../models/instrumento_model.dart';
import '../services/api_service.dart';
import 'catalogo_tela.dart';
import 'carrinho_tela.dart';
import 'detalhes_tela.dart';
import 'favoritos_tela.dart'; // <--- 1. IMPORTANTE: Importamos a tela de favoritos aqui!

class HomeTela extends StatelessWidget {
  const HomeTela({Key? key}) : super(key: key);

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
          // 1. ÍCONE DE LUPA (PESQUISA REAL)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Chama o sistema nativo de busca do Flutter
              showSearch(
                context: context,
                delegate: BuscaInstrumentoDelegate(),
              );
            },
          ),

          // 2. NOVO: ÍCONE DE FAVORITOS (NAVEGAÇÃO)
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritosTela()),
              );
            },
          ),

          // 3. ÍCONE DE CARRINHO (NAVEGAÇÃO)
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ==========================================
            // BANNER DE BOAS-VINDAS AMARELO
            // ==========================================
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE5A93C), // Fundo Amarelo Krunner
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE5A93C).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bem-vindo à Krunner!",
                    style: TextStyle(
                      color: Colors.black, // Texto preto para dar contraste
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Encontre o instrumento perfeito para a sua vibe.",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Carrossel de Banners
            const BannerCarrossel(),

            const SizedBox(height: 20),

            // Grid de Categorias
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "CATEGORIAS DESTAQUE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              children: [
                _buildCardCategoria(context, "Sopro", Icons.air),
                _buildCardCategoria(context, "Cordas", Icons.music_note),
                _buildCardCategoria(context, "Percussão", Icons.waves),
                _buildCardCategoria(context, "Teclas", Icons.piano),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardCategoria(
    BuildContext context,
    String nome,
    IconData icone,
  ) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CatalogoTela(categoria: nome)),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 40, color: const Color(0xFFE5A93C)),
            const SizedBox(height: 8),
            Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// CLASSE DE PESQUISA (DELEGATE) - Executa o filtro de produtos por nome
// =========================================================================
class BuscaInstrumentoDelegate extends SearchDelegate {
  final ApiService _apiService = ApiService();

  // Altera o texto que aparece na barra de pesquisa
  @override
  String get searchFieldLabel => 'Buscar por nome...';

  // Personaliza as cores da barra de pesquisa para o padrão Krunner
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  // Botão de "Limpar" (X) no final da barra
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpa o que foi digitado
        },
      ),
    ];
  }

  // Botão de "Voltar" (Seta) no começo da barra
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Fecha a tela de pesquisa
      },
    );
  }

  // O que mostra quando o usuário clica em "Enter" (Resultados)
  @override
  Widget buildResults(BuildContext context) {
    return _construirListaFiltrada();
  }

  // O que mostra enquanto o usuário está digitando (Sugestões em tempo real)
  @override
  Widget buildSuggestions(BuildContext context) {
    return _construirListaFiltrada();
  }

  // Lógica principal: Busca da API e filtra pela palavra digitada
  Widget _construirListaFiltrada() {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: FutureBuilder<List<Instrumento>>(
        future: _apiService.buscarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFE5A93C)),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Erro ao carregar itens."));
          }

          final todosItens = snapshot.data!;

          // Filtra a lista inteira baseada no texto da pesquisa (ignora maiúsculas e minúsculas)
          final resultados = todosItens.where((item) {
            return item.nome.toLowerCase().contains(query.toLowerCase());
          }).toList();

          if (resultados.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum instrumento encontrado com esse nome.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // Se achou, mostra o GridView com os cartões
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: resultados.length,
            itemBuilder: (context, index) {
              final item = resultados[index];
              return InstrumentoCard(
                instrumento: item,
                favoritado: false,
                onFavoritoPressed: () {},
                onTap: () {
                  // Clicar no resultado também leva para os Detalhes
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalhesTela(instrumento: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
