import 'package:flutter/material.dart';
import 'package:portfolio/components/FormacaoCard.dart';
import 'package:portfolio/components/SkillBadge.dart';
import 'package:portfolio/components/SocialSection.dart';
import 'package:portfolio/components/HeaderOnda.dart';
import 'package:portfolio/screens/projetos.dart';

class SobreMim extends StatelessWidget {
  const SobreMim({super.key});

  @override
  Widget build(BuildContext context) {
    // Captura as dimensões da tela para responsividade
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final List<String> skills = [
      "images/vue.png",
      "images/python.png",
      "images/react.png",
      "images/django.png",
      "images/java.png",
      "images/fastapi.png",
      "images/docker.png",
      "images/arduino.png",
      "images/mysql.png",
      "images/flutter.png",
    ];

    // Ajusta a fração do carrossel baseada na largura da tela
    // Se a tela for muito larga (ex: tablet), mostra mais itens
    double viewportFraction = screenWidth > 600 ? 0.2 : 0.3;

    final PageController pageController = PageController(
      viewportFraction: viewportFraction,
      initialPage: 1000,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderOnda(titulo: "Sobre mim", mostrarBotaoVoltar: true),

            Padding(
              // Padding responsivo (6% da largura da tela)
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título com tamanho de fonte responsivo
                  Text(
                    "Olá, eu sou a Thainara 👋",
                    style: TextStyle(
                      fontSize:
                          screenWidth *
                          0.06, // Aprox. 24-26px em celulares comuns
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF531B24),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Estudante atualmente focada em Análise e Desenvolvimento de Sistemas e na criação de experiências digitais memoráveis.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.038, // Aprox. 16px
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  const Text(
                    "Trajetória",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const FormacaoCard(
                    curso: "Análise e Desenv. de Sistemas",
                    instituicao: "SENAI Roberto Mange",
                    periodo: "2025 - 2026",
                  ),
                  const FormacaoCard(
                    curso: "Técnico em Desenv. de Sistemas",
                    instituicao: "SENAI Roberto Mange",
                    periodo: "2025 - 2026",
                  ),
                  const FormacaoCard(
                    curso: "Técnico em Eletroeletrônica",
                    instituicao: "SENAI Roberto Mange",
                    periodo: "2023 - 2024",
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  const Text(
                    "Tech Stack",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Carrossel Responsivo
                  SizedBox(
                    height:
                        screenHeight * 0.12, // Altura baseada na altura da tela
                    child: PageView.builder(
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final imagePath = skills[index % skills.length];
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SkillBadge(imagePath: imagePath),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                  const SocialSection(),
                  SizedBox(height: screenHeight * 0.05),

                  // Seção de Saída/Botão
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Quer ver o que eu já construí?",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Projetos(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.rocket_launch,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Ver Meus Projetos",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF531B24),
                            minimumSize: Size(
                              screenWidth * 0.7,
                              50,
                            ), // Botão ocupa 70% da largura
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
