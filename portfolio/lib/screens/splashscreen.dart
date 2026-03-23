import 'package:flutter/material.dart';
import 'package:portfolio/screens/sobre.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            top: 80,
            left: 0,
            right: 0,
            child: Text(
              "Portfólio",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 90,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          // IMAGEM
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset("images/thainara.png", height: 600),
            ),
          ),

          // PARTE BRANCA COM ONDA
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: OndaClipper(),
              child: Container(
                height: 340,
                width: double.infinity,
                color: const Color(0xFFEDEDED),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Conheça um pouco sobre",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Thainara Marques",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF531B24),
                      ),
                    ),

                    const SizedBox(height: 35),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF531B24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SobreMim()),
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
