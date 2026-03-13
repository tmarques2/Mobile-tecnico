import 'package:coffee_shop/components/botaoprincipal.dart';
import 'package:coffee_shop/components/descricao.dart';
import 'package:coffee_shop/components/titulo.dart';
import 'package:coffee_shop/screens/telaprincipal.dart';
import 'package:flutter/material.dart';

class Telainicial extends StatelessWidget {
  const Telainicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E9DA),
      appBar: AppBar(
        title: Text("Bem Vindo", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6F4E37),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Titulo(),
            SizedBox(height: 30),
            Image.asset('images/logo.png', width: 200),
            SizedBox(height: 30),
            Descricao(texto: "Bem vindo ao app mais famoso de café"),
            SizedBox(height: 30),
            Botaoprincipal(pagina: Principal(), texto: "Entrar"),
          ],
        ),
      ),
    );
  }
}
