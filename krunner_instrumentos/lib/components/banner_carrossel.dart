import 'dart:async';
import 'package:flutter/material.dart';

// Importações dos seus modelos, telas e do ApiService real
import '../screens/detalhes_tela.dart';
import '../models/instrumento_model.dart';
import '../services/api_service.dart'; 

class BannerCarrossel extends StatefulWidget {
  const BannerCarrossel({Key? key}) : super(key: key);

  @override
  State<BannerCarrossel> createState() => _BannerCarrosselState();
}

class _BannerCarrosselState extends State<BannerCarrossel> {
  final PageController _pageController = PageController();
  final ApiService _apiService = ApiService();
  
  int _paginaAtual = 0;
  Timer? _timer;
  
  List<Instrumento> _ofertas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosDaApi();
  }

  // Busca a lista real direto do repositório da sua API
  Future<void> _carregarDadosDaApi() async {
    try {
      final listaProdutos = await _apiService.buscarTodos();
      if (mounted) {
        setState(() {
          // Pegamos apenas os 3 primeiros produtos reais retornados pela sua API
          _ofertas = listaProdutos.take(3).toList();
          _carregando = false;
        });
        
        _iniciarTimerCarrossel();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
      print("Erro ao carregar dados reais da API: $e");
    }
  }

  void _iniciarTimerCarrossel() {
    if (_ofertas.isEmpty) return;

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        if (_paginaAtual < _ofertas.length - 1) {
          _paginaAtual++;
        } else {
          _paginaAtual = 0;
        }

        _pageController.animateToPage(
          _paginaAtual,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Limpa o timer para evitar vazamento de memória
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apresenta o indicador de progresso enquanto os dados reais não chegam
    if (_carregando) {
      return const SizedBox(
        height: 180,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFFE5A93C)),
        ),
      );
    }

    // Se o banco de dados retornar vazio, não renderiza um carrossel quebrado
    if (_ofertas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 180, 
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _paginaAtual = page;
              });
            },
            itemCount: _ofertas.length,
            itemBuilder: (context, index) {
              // Pega o objeto Instrumento real vindo do banco
              final instrumentoReal = _ofertas[index];
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E), 
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5A93C),
                    width: 1,
                  ), 
                ),
                child: Row(
                  children: [
                    // URL da imagem real vinda da API
                    Container(
                      width: 100,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          instrumentoReal.imagemUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Detalhes do produto real
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            instrumentoReal.nome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Formata o preço decimal real vindo da API
                          Text(
                            "R\$ ${instrumentoReal.preco.toStringAsFixed(2).replaceAll('.', ',')}",
                            style: const TextStyle(
                              color: Color(0xFFE5A93C), 
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Envia o objeto real e completo para a DetalhesTela
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalhesTela(
                                      instrumento: instrumentoReal,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE5A93C),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                "Conferir",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Quantidade de bolinhas fixada no limite de até 3 itens da API
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _ofertas.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _paginaAtual == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _paginaAtual == index
                    ? const Color(0xFFE5A93C)
                    : Colors.grey.shade700,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}