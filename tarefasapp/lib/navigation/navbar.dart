import 'package:flutter/material.dart';
import 'package:tarefasapp/screens/teladelete.dart';
import 'package:tarefasapp/screens/telaget.dart';
import 'package:tarefasapp/screens/telapost.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int indexAtual = 0; //ve qual tela ta selecionada
  List pages = [TelaGet(), TelaDelete(), TelaPost()];

  void mudarIndex(int novoIndex) {
    setState(() {
      indexAtual = novoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(indexAtual),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.get_app), label: "Get"),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: "Delete"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Post"),
        ],
        currentIndex: indexAtual,
        onTap: mudarIndex,
      ),
    );
  }
}
