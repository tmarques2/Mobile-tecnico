import 'package:flutter/material.dart';
import 'package:portfolio/components/FormacaoCard.dart';
import 'package:portfolio/components/SkillBadge.dart';
import 'package:portfolio/components/SocialSection.dart';

class SobreMim extends StatelessWidget {
  const SobreMim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5F5F5,
      ), // Cinza bem claro para contraste
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER COM ONDA
            Stack(
              children: [
                ClipPath(
                  clipper: OndaTopoClipper(),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF531B24), Color(0xFF6A2931)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Sobre mim",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BIO INTERATIVA
                  const Text(
                    "Olá, eu sou a Thainara 👋",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF531B24),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Desenvolvedora atualmente focada em Análise e Desenvolvimento de Sistemas e na criação de experiências digitais memoráveis.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // SEÇÃO TRAJETÓRIA
                  const Text(
                    "Trajetória",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const FormacaoCard(
                    curso: "Análise e Desenv. de Sistemas",
                    instituicao: "SENAI Roberto Mange",
                    periodo: "2025 - 2026",
                  ),
                  const FormacaoCard(
                    curso: "Técnico em Eletroeletrônica",
                    instituicao: "SENAI Roberto Mange",
                    periodo: "2023 - 2024",
                  ),

                  const SizedBox(height: 20),

                  // SEÇÃO TECH STACK
                  const Text(
                    "Tech Stack",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 20,
                      children: const [
                        SkillBadge(imagePath: "images/vue.png"),
                        SkillBadge(imagePath: "images/python.png"),
                        SkillBadge(imagePath: "images/react.png"),
                        SkillBadge(imagePath: "images/django.png"),
                        SkillBadge(imagePath: "images/java.png"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  // COMPONENTE DE REDES SOCIAIS (Requisito SA1)
                  const SocialSection(),

                  const SizedBox(height: 40),

                  // SEÇÃO DE PROJETOS (Botão para cumprir o último requisito da lista)
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Quer ver o que eu já construí?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Aqui você deve colocar a navegação para sua tela de projetos
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const MeusProjetos()));
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
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

// CLIPPER DA ONDA SUPERIOR
class OndaTopoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);

    var firstControlPoint = Offset(size.width * 0.25, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 35);

    var secondControlPoint = Offset(size.width * 0.75, size.height - 75);
    var secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
