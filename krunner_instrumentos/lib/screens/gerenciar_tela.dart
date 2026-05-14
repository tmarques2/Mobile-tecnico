import 'package:flutter/material.dart';
import '../models/instrumento_model.dart';
import '../services/api_service.dart';
import 'formulario_instrumento_tela.dart';

// Novos imports necessários para a AppBar padrão funcionar
import 'home_tela.dart';
import 'favoritos_tela.dart';
import 'carrinho_tela.dart';

class GerenciarTela extends StatefulWidget {
  const GerenciarTela({Key? key}) : super(key: key);

  @override
  State<GerenciarTela> createState() => _GerenciarTelaState();
}

class _GerenciarTelaState extends State<GerenciarTela> {
  final ApiService _apiService = ApiService();

  void _atualizarLista() {
    setState(() {}); // Recarrega o FutureBuilder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ==========================================
      // NOVA APPBAR: LOGO + ADICIONAR + PADRÕES
      // ==========================================
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
          // 1. ÍCONE DE ADICIONAR (Específico desta tela)
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFFE5A93C),
            ),
            tooltip: "Adicionar Instrumento",
            onPressed: () async {
              // Vai para o formulário sem passar objeto (Modo: Adicionar)
              final mudou = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FormularioInstrumentoTela(),
                ),
              );
              if (mudou == true) _atualizarLista();
            },
          ),
          // 2. ÍCONE DE LUPA (PESQUISA)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BuscaInstrumentoDelegate(),
              );
            },
          ),
          // 3. ÍCONE DE FAVORITOS
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritosTela()),
              );
            },
          ),
          // 4. ÍCONE DE CARRINHO
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
      body: FutureBuilder<List<Instrumento>>(
        future: _apiService.buscarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFE5A93C)),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text("Erro ao conectar ao JSON Server."),
            );
          }

          final lista = snapshot.data!;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index];
              return Card(
                color: const Color(0xFF1E1E1E),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Image.network(
                    item.imagemUrl,
                    width: 50,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image),
                  ),
                  title: Text(
                    item.nome,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "R\$ ${item.preco.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botão Editar (PUT)
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final mudou = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormularioInstrumentoTela(
                                instrumento: item,
                              ), // Passa o objeto para preencher os campos
                            ),
                          );
                          if (mudou == true) _atualizarLista();
                        },
                      ),
                      // Botão Deletar (DELETE)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          bool confirmado = await _confirmarExclusao(context);
                          if (confirmado) {
                            await _apiService.deletarInstrumento(item.id);
                            _atualizarLista();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> _confirmarExclusao(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: const Text("Excluir Instrumento?"),
            content: const Text(
              "Essa ação não poderá ser desfeita no seu JSON Server.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Excluir",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
