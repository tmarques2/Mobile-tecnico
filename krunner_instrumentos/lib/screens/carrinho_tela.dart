import 'package:flutter/material.dart';
import 'package:krunner_instrumentos/screens/pagamento_tela.dart';
import '../services/carrinho_service.dart';

class CarrinhoTela extends StatefulWidget {
  const CarrinhoTela({Key? key}) : super(key: key);

  @override
  State<CarrinhoTela> createState() => _CarrinhoTelaState();
}

class _CarrinhoTelaState extends State<CarrinhoTela> {
  final CarrinhoService _carrinho = CarrinhoService();

  @override
  Widget build(BuildContext context) {
    final itensUnicos = _carrinho.itens.toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meu Carrinho",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF121212),
      ),
      body: _carrinho.itens.isEmpty
          ? const Center(
              child: Text(
                "Seu carrinho está vazio.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _carrinho
                        .itens
                        .length, // Agora a lista já é naturalmente única!
                    itemBuilder: (context, index) {
                      // Obtém o item do carrinho (que já contém o instrumento e a quantidade)
                      final itemCarrinho = _carrinho.itens[index];
                      final instrumento = itemCarrinho.instrumento;
                      final quantidade = itemCarrinho.quantidade;

                      final subtotalItem = instrumento.preco * quantidade;

                      return Card(
                        color: const Color(0xFF1E1E1E),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          leading: Image.network(
                            instrumento.imagemUrl,
                            width: 50,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.music_note,
                                  size: 40,
                                  color: Color(0xFFE5A93C),
                                ),
                          ),
                          title: Text(
                            instrumento.nome,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "R\$ ${subtotalItem.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Color(0xFFE5A93C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Botão de diminuir quantidade
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _carrinho.remover(instrumento);
                                  });
                                },
                              ),
                              // Texto da quantidade
                              Text(
                                "$quantidade",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Botão de aumentar quantidade
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xFFE5A93C),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _carrinho.adicionar(instrumento);
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors
                                      .grey, // Cor neutra para não brigar com o visual, mas você pode usar vermelho se preferir
                                ),
                                onPressed: () {
                                  setState(() {
                                    _carrinho.deletar(instrumento);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "R\$ ${_carrinho.total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE5A93C),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE5A93C),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PagamentoTela(),
                              ),
                            );
                          },
                          child: const Text(
                            "Continuar",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
