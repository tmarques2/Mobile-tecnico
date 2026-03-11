import 'package:amplify/login.dart';
import 'package:flutter/material.dart';

class PaginaOnboarding extends StatefulWidget {
  const PaginaOnboarding({super.key});

  @override
  State<PaginaOnboarding> createState() => _PaginaOnboardingState();
}

class _PaginaOnboardingState extends State<PaginaOnboarding> {
  // Controle do índice da página atual
  int indiceAtual = 0;

  // Lista com os dados de cada tela
  final List<Map<String, String>> dadosOnboarding = [
    {
      "imagem": "images/deftones-integrantes.webp",
      "texto": "Conheça as melhores bandas de nu metal",
    },
    {
      "imagem": "images/slipknot-integrantes.jpg",
      "texto": "Clássicos que você precisa ouvir",
    },
  ];

  void proximaPagina() {
    setState(() {
      if (indiceAtual < dadosOnboarding.length - 1) {
        indiceAtual++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PaginaLogin()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Imagem de Fundo
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(dadosOnboarding[indiceAtual]["imagem"]!),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Overlay escuro e conteúdo
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dadosOnboarding[indiceAtual]["texto"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Indicadores (Pontinhos)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      dadosOnboarding.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: indiceAtual == index
                              ? Colors.red[900]
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Botão Próximo
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: proximaPagina,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Próximo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
