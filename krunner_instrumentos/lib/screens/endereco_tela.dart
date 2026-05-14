import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_tela.dart'; // Para voltar ao início

class EnderecoTela extends StatefulWidget {
  final String metodoPagamento;

  const EnderecoTela({Key? key, required this.metodoPagamento})
    : super(key: key);

  @override
  State<EnderecoTela> createState() => _EnderecoTelaState();
}

class _EnderecoTelaState extends State<EnderecoTela> {
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _numeroController = TextEditingController();

  bool _carregandoCep = false;

  // Função que consome a API do ViaCEP
  Future<void> _buscarCep(String cep) async {
    // Remove tudo que não for número
    cep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cep.length != 8) return;

    setState(() {
      _carregandoCep = true;
    });

    try {
      final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.containsKey('erro')) {
          _mostrarSnackBar("CEP não encontrado.");
        } else {
          setState(() {
            _ruaController.text = data['logradouro'] ?? '';
            _bairroController.text = data['bairro'] ?? '';
            _cidadeController.text = data['localidade'] ?? '';
            _estadoController.text = data['uf'] ?? '';
          });
        }
      }
    } catch (e) {
      _mostrarSnackBar("Erro ao buscar o CEP. Verifique sua internet.");
    } finally {
      setState(() {
        _carregandoCep = false;
      });
    }
  }

  void _mostrarSnackBar(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void _finalizarCompra() {
    if (_cepController.text.isEmpty || _numeroController.text.isEmpty) {
      _mostrarSnackBar("Preencha o CEP e o Número da residência.");
      return;
    }

    // Limpa o carrinho e avisa do sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Compra finalizada com sucesso!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );

    // Volta para a tela Home e apaga o histórico de navegação (para não voltar pro carrinho)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeTela()),
      (Route<dynamic> route) =>
          false, // Remove todas as telas anteriores da pilha
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Endereço de Entrega"),
        backgroundColor: const Color(0xFF121212),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de CEP
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: "Digite seu CEP",
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: const OutlineInputBorder(),
                suffixIcon: _carregandoCep
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFE5A93C),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color(0xFFE5A93C),
                        ),
                        onPressed: () => _buscarCep(_cepController.text),
                      ),
              ),
              onChanged: (value) {
                if (value.length == 8) {
                  _buscarCep(value);
                }
              },
            ),
            const SizedBox(height: 10),

            // Campos preenchidos automaticamente
            _buildTextField("Rua", _ruaController),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    "Número",
                    _numeroController,
                    readOnly: false,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField("Bairro", _bairroController)),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField("Cidade", _cidadeController),
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField("UF", _estadoController)),
              ],
            ),

            const SizedBox(height: 40),

            // Resumo
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE5A93C).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5A93C)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFFE5A93C)),
                  const SizedBox(width: 10),
                  Text(
                    "Pagamento via: ${widget.metodoPagamento}",
                    style: const TextStyle(
                      color: Color(0xFFE5A93C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Botão Finalizar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5A93C),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _finalizarCompra,
              child: const Text(
                "Finalizar Compra",
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

  // Widget auxiliar para não repetir código de TextField
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = true,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: readOnly ? Colors.grey : Colors.white),
      ),
      style: TextStyle(color: readOnly ? Colors.grey : Colors.white),
    );
  }
}
