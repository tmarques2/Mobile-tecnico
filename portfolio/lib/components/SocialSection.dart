import 'package:flutter/material.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Redes Sociais & Contato",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialImageButton(
              imagePath:
                  "images/github.png", // Certifique-se de ter essa imagem
              label: "GitHub",
              onTap: () => print("Link GitHub"),
            ),
            _buildSocialImageButton(
              imagePath: "images/linkedin.png",
              label: "LinkedIn",
              onTap: () => print("Link LinkedIn"),
            ),
            _buildSocialImageButton(
              imagePath: "images/instagram.png",
              label: "Instagram",
              onTap: () => print("Link Instagram"),
            ),
            _buildSocialImageButton(
              imagePath: "images/email.png",
              label: "Email",
              onTap: () => print("Link Email"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialImageButton({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.link),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
