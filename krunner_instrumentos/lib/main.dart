import 'package:flutter/material.dart';
import 'screens/base_tela.dart';

void main() {
  runApp(const MusicVibeApp());
}

class MusicVibeApp extends StatelessWidget {
  const MusicVibeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krunner Instrumentos',
      theme: ThemeData(
        brightness: Brightness.dark, // Define o tema base como escuro
        fontFamily: 'Montserrat', // Fonte GLobal
        scaffoldBackgroundColor: const Color(
          0xFF121212,
        ), // Fundo Grafite Escuro da Krunner
        primaryColor: const Color(0xFFE5A93C), // Amarelo Krunner
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE5A93C),
          secondary: Color(0xFF2C6B3F), // Verde do botão comprar
          surface: Color(0xFF1E1E1E), // Fundo dos cards
        ),
      ),
      home: const BaseTela(),
    );
  }
}
