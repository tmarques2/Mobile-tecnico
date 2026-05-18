import 'package:flutter/material.dart';
import 'home_tela.dart';
import 'catalogo_tela.dart';
import 'gerenciar_tela.dart';

class BaseTela extends StatefulWidget {
  const BaseTela({Key? key}) : super(key: key);

  @override
  State<BaseTela> createState() => _BaseTelaState();
}

class _BaseTelaState extends State<BaseTela> {
  int _abaSelecionada = 0;

  final List<Widget> _telas = [
    const HomeTela(),
    const CatalogoTela(),
    const GerenciarTela(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _abaSelecionada, children: _telas),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaSelecionada,
        onTap: (index) {
          setState(() {
            _abaSelecionada = index;
          });
        },
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: const Color(0xFFE5A93C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Gerenciar',
          ),
        ],
      ),
    );
  }
}
