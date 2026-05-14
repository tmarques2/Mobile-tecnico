import 'package:flutter/material.dart';
import '../models/instrumento_model.dart';
import '../services/api_service.dart';

class FormularioInstrumentoTela extends StatefulWidget {
  final Instrumento?
  instrumento; // Opcional: Se vier preenchido, é EDIÇÃO. Se nulo, é CADASTRO.

  const FormularioInstrumentoTela({Key? key, this.instrumento})
    : super(key: key);

  @override
  State<FormularioInstrumentoTela> createState() =>
      _FormularioInstrumentoTelaState();
}

class _FormularioInstrumentoTelaState extends State<FormularioInstrumentoTela> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  late TextEditingController _nomeController;
  late TextEditingController _precoController;
  late TextEditingController _imagemController;
  late TextEditingController _categoriaController;

  bool _estaEditando = false;

  @override
  void initState() {
    super.initState();
    _estaEditando = widget.instrumento != null;

    // Inicializa os controladores com os dados existentes ou vazios
    _nomeController = TextEditingController(
      text: _estaEditando ? widget.instrumento!.nome : '',
    );
    _precoController = TextEditingController(
      text: _estaEditando ? widget.instrumento!.preco.toString() : '',
    );
    _imagemController = TextEditingController(
      text: _estaEditando ? widget.instrumento!.imagemUrl : '',
    );
    _categoriaController = TextEditingController(
      text: _estaEditando ? widget.instrumento!.categoria : 'Cordas',
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _imagemController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  // 1. ATUALIZE O MÉTODO DE SALVAR COM TRATAMENTO DE EXCEÇÃO (try/catch)
  void _salvarFormulario() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Tenta converter o texto para número decimal
        double precoConvertido = double.parse(
          _precoController.text.replaceAll(',', '.'),
        );

        final instrumentoDados = Instrumento(
          id: _estaEditando
              ? widget.instrumento!.id
              : DateTime.now().millisecondsSinceEpoch.toString(),
          nome: _nomeController.text,
          preco: precoConvertido,
          imagemUrl: _imagemController.text,
          categoria: _categoriaController.text,
        );

        bool sucesso;
        if (_estaEditando) {
          sucesso = await _apiService.atualizarInstrumento(
            widget.instrumento!.id,
            instrumentoDados,
          );
        } else {
          sucesso = await _apiService.criarInstrumento(instrumentoDados);
        }

        if (sucesso) {
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Erro ao salvar dados no JSON Server."),
            ),
          );
        }
      } catch (e) {
        // Se o usuário burlar e digitar algo inválido, a exceção é capturada aqui sem quebrar o app!
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Formato de preço inválido! Use apenas números e ponto (Ex: 250.00).",
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_estaEditando ? "Editar Produto" : "Novo Produto"),
        backgroundColor: const Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Instrumento',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  validator: (value) => value!.isEmpty ? 'Insira o nome' : null,
                ),
                const SizedBox(height: 12),
                // 2. ADICIONE AS DUAS NOVAS LINHAS NO TEXTFORMFIELD DE PREÇO (Dentro do seu build)
                TextFormField(
                  controller: _precoController,
                  decoration: const InputDecoration(
                    labelText: 'Preço (Ex: 250.00)',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ), // Garante teclado numérico
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Insira o preço';
                    if (double.tryParse(value.replaceAll(',', '.')) == null)
                      return 'Digite um número válido';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _imagemController,
                  decoration: const InputDecoration(
                    labelText: 'URL da Imagem',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Insira a URL da imagem' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _categoriaController,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Insira a categoria' : null,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF2C6B3F,
                      ), // Verde Krunner para salvar
                    ),
                    onPressed: _salvarFormulario,
                    child: Text(
                      _estaEditando
                          ? "Salvar Alterações"
                          : "Cadastrar Instrumento",
                      style: const TextStyle(
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
      ),
    );
  }
}
