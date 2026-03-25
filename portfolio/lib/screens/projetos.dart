import 'package:flutter/material.dart';
import 'package:portfolio/components/HeaderOnda.dart';
import 'package:portfolio/components/ProjetoCard.dart'; // Importe aqui

class Projetos extends StatelessWidget {
  const Projetos({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderOnda(titulo: "Projetos", mostrarBotaoVoltar: true),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                children: [
                  // Agora você usa o componente como uma tag HTML/Widget comum
                  const ProjetoCard(
                    imagePath: "images/flink_logo.png",
                    titulo: "FLINK",
                    descricao:
                        "Centralização de informação, integração entre plataformas como SAP, excel e Power BI.",
                  ),
                  const ProjetoCard(
                    imagePath: "images/breeze_logo.png",
                    titulo: "Breeze",
                    descricao:
                        "Plataforma de monitoramento climático em tempo real e controle de dispositivos prediais.",
                  ),
                  const ProjetoCard(
                    imagePath: "images/autron_logo.png",
                    titulo: "AUTRON",
                    descricao:
                        "Robô Humanoide para um espaço automotivo feito com inteligência artificial e que conversa com as pessoas.",
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
