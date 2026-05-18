import 'package:flutter/material.dart';
import 'screens/splash_tela.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KrunnerInstrumentos());
}

class KrunnerInstrumentos extends StatelessWidget {
  const KrunnerInstrumentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krunner Instrumentos',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFE5A93C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE5A93C),
          secondary: Color(0xFF2C6B3F),
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const KrunnerSplashScreen(),
    );
  }
}
