import 'package:flutter/material.dart';
import 'package:portfolio/screens/sobre.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pega as dimensões da tela atual
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // FUNDO COM GRADIENTE
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF531B24), Color(0xFF6A2931)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // TITULO PORTFÓLIO
          Positioned(
            top: screenHeight * 0.08,
            left: 0,
            right: 0,
            child: Text(
              "Portfólio",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.21,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          // IMAGEM THAI
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "images/thainara.png",
                height: screenHeight * 0.65,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // PARTE BRANCA COM ONDA
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: OndaClipper(),
              child: Container(
                height: screenHeight * 0.35,
                width: double.infinity,
                color: const Color(0xFFEDEDED),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      "Conheça um pouco sobre",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Thainara Marques",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF531B24),
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF531B24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SobreMim(),
                          ),
                        );
                      },
                      child: const Text(
                        "Vamos lá!",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OndaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, 40);
    path.quadraticBezierTo(size.width * 0.75, 80, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
