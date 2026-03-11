import 'package:amplify/main.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 80),
            SizedBox(
              width: 300,
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Usuário',
                  hintText: 'Digite seu usuário',
                  prefixIcon: Icon(
                    Icons.person,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 177, 10, 10),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 177, 10, 10),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            SizedBox(height: 50),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                backgroundColor: Color.fromARGB(255, 177, 24, 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                );
              },
              child: const Text(
                "Entrar",
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Não tem conta?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                    );
                  },
                  child: Text(
                    "Cadastre-se",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 68, 68),
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
