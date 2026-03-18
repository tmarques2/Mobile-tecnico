import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Links extends StatelessWidget {
  final String url;
  final String imagem;

  Links({super.key, required this.url, required this.imagem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            child: Image.network(imagem),
            onTap: () async {
              Uri converterUrl = Uri.parse(url);

              if (await canLaunchUrl(converterUrl)) {
                await launchUrl(
                  converterUrl,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                debugPrint("Não foi possível abrir o link");
              }
            },
          ),
        ],
      ),
    );
  }
}
