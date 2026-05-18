import 'package:flutter/material.dart';
import 'base_tela.dart';
import '../services/carrinho_service.dart';
import '../services/favoritos_service.dart';

class KrunnerSplashScreen extends StatefulWidget {
  const KrunnerSplashScreen({Key? key}) : super(key: key);

  @override
  State<KrunnerSplashScreen> createState() => _KrunnerSplashScreenState();
}

class _KrunnerSplashScreenState extends State<KrunnerSplashScreen> {
  @override
  void initState() {
    super.initState();
    _inicializarApp();
  }

  Future<void> _inicializarApp() async {
    // 1. Força a tela de Splash a segurar por pelo menos 2 segundos
    final tempoMinimoSplash = Future.delayed(const Duration(seconds: 2));

    // 2. Carrega os dados locais salvos no dispositivo em paralelo
    final carregarDadosLocais = Future(() async {
      try {
        await CarrinhoService().carregarCarrinho();
        await FavoritosService().carregarFavoritos();
      } catch (e) {
        print("Erro ao carregar dados locais: $e");
      }
    });

    // 3. Aguarda ambos os processos terminarem
    await Future.wait([tempoMinimoSplash, carregarDadosLocais]);

    // 4. Vai para a BaseTela limpando a Splash da memória
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BaseTela()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fundo Grafite Escuro
      body: Stack(
        children: [
          // Conteúdo Central (Identidade Visual Krunner)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "KRUNNER",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4.0,
                    color: Color(0xFFE5A93C), // Amarelo Krunner
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "INSTRUMENTOS",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 6.0,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Indicador de Carregamento sutil embaixo
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE5A93C)),
                backgroundColor: Colors.white.withOpacity(0.1),
                strokeWidth: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}