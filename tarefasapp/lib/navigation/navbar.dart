import 'package:flutter/material.dart';
import 'package:tarefasapp/screens/teladelete.dart';
import 'package:tarefasapp/screens/telaget.dart';
import 'package:tarefasapp/screens/telalocal.dart';
import 'package:tarefasapp/screens/telapost.dart';
import 'package:tarefasapp/screens/telaput.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int indexAtual = 0;

  final List pages = [
    TelaGet(),
    TelaDelete(),
    TelaPost(),
    TelaPut(),
    TelaLocal(),
  ];

  void mudarIndex(int novoIndex) {
    setState(() {
      indexAtual = novoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexAtual],

      bottomNavigationBar: Container(
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

        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: indexAtual,
          onTap: mudarIndex,

          type: BottomNavigationBarType.fixed,

          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,

          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.download_rounded),
              label: "Get",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delete_outline),
              label: "Delete",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: "Post",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note_rounded),
              label: "Put",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.computer), label: "Local"),
          ],
        ),
      ),
    );
  }
}
