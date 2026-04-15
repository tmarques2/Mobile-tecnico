import 'package:flutter/material.dart';
import 'package:tarefasapp/navigation/navbar.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // pushReplacement evita que o usuário volte para a SplashScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navbar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 122, 20, 54),
              Color.fromARGB(255, 209, 62, 114),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(), // Empurra o conteúdo para o meio
            // Ícone nativo (carrega na hora e fica branco, contrastando com o fundo)
            const Icon(Icons.task_alt_rounded, size: 110, color: Colors.white),
            const SizedBox(height: 24),

            // Título principal
            const Text(
              "Thasks",
              style: TextStyle(
                fontSize: 42,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0, // Dá um visual mais elegante
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: Divider(color: Colors.white54),
            ),

            // Subtítulo
            const Text(
              "Seu app de gerenciamento de tarefas",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            const Spacer(), // Empurra o loading para o fundo
            // Indicador de carregamento
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 48), // Margem inferior
          ],
        ),
      ),
    );
  }
}
