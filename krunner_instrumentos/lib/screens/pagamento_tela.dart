import 'package:flutter/material.dart';
import 'endereco_tela.dart'; // Importaremos a próxima tela

class PagamentoTela extends StatefulWidget {
  const PagamentoTela({Key? key}) : super(key: key);

  @override
  State<PagamentoTela> createState() => _PagamentoTelaState();
}

class _PagamentoTelaState extends State<PagamentoTela> {
  String _metodoSelecionado = "Pix";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Método de Pagamento"),
        backgroundColor: const Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Como você prefere pagar?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Opções de Pagamento
            _buildOpcaoPagamento("Pix", Icons.pix),
            _buildOpcaoPagamento("Cartão de Crédito", Icons.credit_card),
            _buildOpcaoPagamento("Boleto Bancário", Icons.receipt),

            const Spacer(),

            // Botão Continuar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5A93C),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EnderecoTela(metodoPagamento: _metodoSelecionado),
                  ),
                );
              },
              child: const Text(
                "Continuar para Entrega",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpcaoPagamento(String titulo, IconData icone) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.only(bottom: 12),
      child: RadioListTile<String>(
        title: Row(
          children: [
            Icon(icone, color: Colors.white),
            const SizedBox(width: 10),
            Text(titulo, style: const TextStyle(color: Colors.white)),
          ],
        ),
        value: titulo,
        groupValue: _metodoSelecionado,
        activeColor: const Color(0xFFE5A93C),
        onChanged: (String? value) {
          setState(() {
            _metodoSelecionado = value!;
          });
        },
      ),
    );
  }
}
