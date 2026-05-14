import 'package:flutter/material.dart';
import '../models/instrumento_model.dart';

class InstrumentoCard extends StatelessWidget {
  final Instrumento instrumento;
  final bool favoritado;
  final VoidCallback onFavoritoPressed;
  final VoidCallback onTap;

  const InstrumentoCard({
    Key? key,
    required this.instrumento,
    required this.favoritado,
    required this.onFavoritoPressed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double precoPix = instrumento.preco * 0.9; // 10% de desconto

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Image.network(
                      instrumento.imagemUrl,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.music_note,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        favoritado ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: onFavoritoPressed,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                instrumento.nome,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "R\$ ${precoPix.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE5A93C),
                ),
              ),
              const Text(
                "com 10% de desconto",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C6B3F), // Verde Krunner
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: onTap,
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
