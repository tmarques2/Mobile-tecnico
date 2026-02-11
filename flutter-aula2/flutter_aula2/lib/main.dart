import 'package:flutter/material.dart';

void main() {
  //função principal que executa o codigo
  runApp(TelaContador()); //runApp: roda o app
}

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});
  //voce coloca aqui os parametros da sua tela

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  // Aqui você coloca a sua lógica em dart
  int contador = 0; //variável que ira mostrar o numero da tela

  void add() {
    setState(() {
      contador++; //aumenta 1 unidade do valor da variável
    });
  }

  void sub() {
    setState(() {
      if (contador > 0) {
        contador--; //subtrai 1 unidade do valor da variável
      }
    });
  }

  void reset() {
    setState(() {
      contador = 0; //reseta o valor da variável
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //importa todos os widgets/componentes ex: texto, botao, navbar...
      home: Scaffold(
        //ele permite separar minha home em ate 3 partes
        appBar: AppBar(title: Text("app contador")),
        body: Center(
          //ajuda a centralizar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$contador", style: TextStyle(fontSize: 40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 46, 156, 224),
                    ),
                    onPressed: add,
                    child: Icon(Icons.add),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 46, 156, 224),
                    ),
                    onPressed: sub,
                    child: Icon(Icons.remove),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 46, 156, 224),
                    ),
                    onPressed: reset,
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
