import 'package:banco/screens/paginaPix.dart';
import 'package:banco/screens/paginaCartao.dart';
import 'package:banco/screens/paginaEmprestimo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Centralizadora());
}

class Centralizadora extends StatelessWidget {
  const Centralizadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TelaInicial());
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E5F5),
      appBar: AppBar(
        title: Text(
          "ThaBank",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 117, 19, 137),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Olá, Thainara",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 41, 11, 92),
                ),
              ),
            ),
            // Card do saldo
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: 750,
              height: 190,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 117, 19, 137),
                    Colors.deepPurple,
                  ],
                  begin: Alignment
                      .topLeft, //onde comeca o gradiente (topo esquerda)
                  end: Alignment.bottomRight, //onde termina (fim direita)
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Saldo disponível",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    "R\$ 10.000,00",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    //icone
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white70,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Distribui os botões igualmente
              children: [
                //aq ele ta chamando a função que cria o botao
                _botaoBanco(context, Icons.pix, "Pix", const PaginaPix()),
                _botaoBanco(
                  context,
                  Icons.payments,
                  "Cartão",
                  const PaginaCartao(),
                ),
                _botaoBanco(
                  context,
                  Icons.attach_money,
                  "Empréstimo",
                  const PaginaEmprestimo(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //funcao que cria o botao
  Widget _botaoBanco(
    BuildContext context,
    IconData icon,
    String texto,
    Widget paginaDestino,
  ) {
    return Column(
      children: [
        InkWell(
          //Detecta toque (onclick)
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            // O que acontece quando toca
            Navigator.push(
              //vai pra outra tela
              context,
              MaterialPageRoute(builder: (context) => paginaDestino),
            );
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.deepPurple, size: 30),
          ),
        ),
        SizedBox(height: 8),
        Text(texto, style: TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
