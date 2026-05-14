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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meu Carrinho",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF121212),
      ),
      // Se a lista estiver vazia, mostra o texto. Se não, desenha a coluna.
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
                    itemCount: _carrinho.itens.length,
                    itemBuilder: (context, index) {
                      final item = _carrinho.itens[index];
                      return Card(
                        color: const Color(0xFF1E1E1E),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          // O SEGREDO ESTÁ AQUI: errorBuilder garante que o item não suma se a imagem falhar!
                          leading: Image.network(
                            item.imagemUrl,
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
                            item.nome,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "R\$ ${item.preco.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Color(0xFFE5A93C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                _carrinho.remover(item);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Rodapé com Total e Botão de Finalizar
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
                            // Agora vai para a tela de Pagamento
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
