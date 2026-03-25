import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Não foi possivel abrir $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Redes Sociais & Contato",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialImageButton(
              imagePath: "images/github.png",
              label: "GitHub",
              onTap: () => _launchUrl("https://github.com/tmarques2"),
            ),
            _buildSocialImageButton(
              imagePath: "images/linkedin.png",
              label: "LinkedIn",
              onTap: () => _launchUrl(
                "https://www.linkedin.com/in/thainara-marques-78900326b/",
              ),
            ),
            _buildSocialImageButton(
              imagePath: "images/instagram.png",
              label: "Instagram",
              onTap: () =>
                  _launchUrl("https://www.instagram.com/t.marquezzz0/"),
            ),
            _buildSocialImageButton(
              imagePath: "images/email.png",
              label: "Email",
              onTap: () => _launchUrl("mailto:thainaramarques258@gmail.com"),
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
