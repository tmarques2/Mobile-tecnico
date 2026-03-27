import 'package:flutter/material.dart';

class ProjetoCard extends StatelessWidget {
  final String imagePath;
  final String titulo;
  final String descricao;
  final String? grupo;

  const ProjetoCard({
    super.key,
    required this.imagePath,
    required this.titulo,
    required this.descricao,
    this.grupo,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.only(bottom: 25),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(15),
          iconColor: const Color(0xFF531B24),
          textColor: const Color(0xFF531B24),
          collapsedIconColor: Colors.grey,
          leading: SizedBox(
            width: screenWidth * 0.2,
            // LOGO
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          title: Text(
            titulo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.045,
            ),
          ),
          subtitle: const Text("Toque para saber mais"),
          shape: const Border(),
          collapsedShape: const Border(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),

                  //DESCRIÇÃO
                  Text(
                    descricao,
                    style: TextStyle(
                      color: Colors.grey[700],
                      height: 1.5,
                      fontSize: screenWidth * 0.038,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //FOTO DO GRUPO (OPCIONAL
                  if (grupo != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        grupo!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
