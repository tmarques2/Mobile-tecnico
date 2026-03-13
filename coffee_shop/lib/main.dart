import 'package:coffee_shop/screens/telainicial.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Montserrat",
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown, // cor da appbar
          foregroundColor: Colors.white, // cor da seta e do texto
          centerTitle: true, // opcional
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Telainicial(),
    );
  }
}
