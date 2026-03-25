import 'package:flutter/material.dart';

class FormacaoCard extends StatelessWidget {
  final String curso;
  final String instituicao;
  final String periodo;

  const FormacaoCard({
    super.key,
    required this.curso,
    required this.instituicao,
    required this.periodo,
  });

  @override
  Widget build(BuildContext context) {
    // Captura a largura da tela para ajustar fontes e paddings
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(
        screenWidth * 0.03,
      ), // Padding responsivo (4% da largura)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Detalhe visual lateral - Ajustado para ser sutil em qualquer tela
          Container(
            width: 4,
            height: screenWidth * 0.1, // Altura proporcional à largura da tela
            decoration: BoxDecoration(
              color: const Color(0xFF531B24),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: screenWidth * 0.03), // Espaçamento interno responsivo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  curso,
                  // Fonte responsiva: evita que o título ocupe muitas linhas em telas pequenas
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.032,
                    color: const Color(0xFF531B24),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$instituicao • $periodo",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: screenWidth * 0.025,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
