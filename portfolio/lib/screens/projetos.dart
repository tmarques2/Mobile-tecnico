import 'package:flutter/material.dart';
import 'package:portfolio/components/HeaderOnda.dart';

class Projetos extends StatelessWidget {
  const Projetos({super.key});

  @override
  Widget build(BuildContext context) {
    // Captura as dimensões da tela
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Componente de Header Reutilizável
            const HeaderOnda(titulo: "Projetos", mostrarBotaoVoltar: true),

            Padding(
              // Padding horizontal responsivo (aprox. 6% da largura)
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                children: [
                  _buildProjetoCard(
                    context,
                    screenWidth,
                    imagePath: "images/flink_logo.png",
                    titulo: "FLINK",
                    descricao:
                        "Centralização de informação, integração entre plataformas como SAP, excel e Power BI.",
                  ),
                  _buildProjetoCard(
                    context,
                    screenWidth,
                    imagePath: "images/breeze_logo.png",
                    titulo: "Breeze",
                    descricao:
                        "Plataforma de monitoramento climático em tempo real e controle de dispositivos prediais.",
                  ),
                  _buildProjetoCard(
                    context,
                    screenWidth,
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

  Widget _buildProjetoCard(
    BuildContext context,
    double screenWidth, {
    required String imagePath,
    required String titulo,
    required String descricao,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 25),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(15),
          iconColor: const Color(0xFF531B24),
          textColor: const Color(0xFF531B24),
          collapsedIconColor: Colors.grey,
          // a logo ocupa 20% da largura da tela no máximo
          leading: SizedBox(
            width: screenWidth * 0.2,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          title: Text(
            titulo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04, // Fonte ajustável
            ),
          ),
          subtitle: const Text("Toque para saber mais"),
          shape: const Border(),
          collapsedShape: const Border(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),
                  Text(
                    descricao,
                    style: TextStyle(
                      color: Colors.grey[700],
                      height: 1.5,
                      fontSize: screenWidth * 0.027,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
