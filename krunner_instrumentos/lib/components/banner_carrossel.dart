import 'dart:async';
import 'package:flutter/material.dart';

class BannerCarrossel extends StatefulWidget {
  const BannerCarrossel({Key? key}) : super(key: key);

  @override
  State<BannerCarrossel> createState() => _BannerCarrosselState();
}

class _BannerCarrosselState extends State<BannerCarrossel> {
  final PageController _pageController = PageController();
  int _paginaAtual = 0;
  Timer? _timer;

  // Lista simulando as ofertas destaque da Krunner
  final List<Map<String, String>> _ofertas = [
    {
      "imagem":
          "https://cdn.awsli.com.br/2500x2500/554/554104/produto/34161595/6935-violao-eletrico-aco-takamine-gd30ce-nt-1-hpxzov.jpg",
      "titulo": "Violão Elétrico Aço Takamine",
      "preco": "R\$ 4.009,50 Pix",
    },
    {
      "imagem":
          "https://cdn.awsli.com.br/2500x2500/55/55384/produto/344382145/d_nq_np_2x_956130-mlb78084385717_072024-f-premium-bateria-acustica-dx720-vinho-vhokrbvybn.webp",
      "titulo": "Bateria Acústica Premium",
      "preco": "R\$ 2.499,00 Pix",
    },
    {
      "imagem":
          "https://m.media-amazon.com/images/I/51GZX2FcyzL._AC_UF1000,1000_QL80_.jpg",
      "titulo": "Teclado Yamaha PSR-F52",
      "preco": "R\$ 799,00 Pix",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Configura o Timer para rodar o carrossel automaticamente
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_paginaAtual < _ofertas.length - 1) {
        _paginaAtual++;
      } else {
        _paginaAtual = 0;
      }

      if (_pageController.hasClients) {
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
    _timer?.cancel(); // Limpa o timer para não vazar memória
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180, // Altura do banner baseada no seu print
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _paginaAtual = page;
              });
            },
            itemCount: _ofertas.length,
            itemBuilder: (context, index) {
              final oferta = _ofertas[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E), // Fundo escuro do card
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5A93C),
                    width: 1,
                  ), // Borda dourada
                ),
                child: Row(
                  children: [
                    // Imagem na esquerda
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
                          oferta["imagem"]!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Textos e botão na direita
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            oferta["titulo"]!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            oferta["preco"]!,
                            style: const TextStyle(
                              color: Color(0xFFE5A93C), // Amarelo Krunner
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Ação futura do botão
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
        // Bolinhas indicadoras (Dots) abaixo do carrossel
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
