import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/instrumento_model.dart';

class CarrinhoService {
  static final CarrinhoService _instance = CarrinhoService._internal();
  factory CarrinhoService() => _instance;
  CarrinhoService._internal();

  final List<Instrumento> _itens = [];
  List<Instrumento> get itens => _itens;

  double get total => _itens.fold(0, (total, item) => total + item.preco);

  // Carrega os itens salvos no dispositivo (Deve ser chamado no início do app)
  Future<void> carregarCarrinho() async {
    final prefs = await SharedPreferences.getInstance();
    final String? carrinhoJson = prefs.getString('carrinho_salvo');
    
    if (carrinhoJson != null) {
      final List<dynamic> dadosDecodificados = jsonDecode(carrinhoJson);
      _itens.clear();
      _itens.addAll(
        dadosDecodificados.map((item) => Instrumento.fromJson(item)).toList()
      );
    }
  }

  // Salva o estado atual da lista no dispositivo
  Future<void> _salvarNoDispositivo() async {
    final prefs = await SharedPreferences.getInstance();
    final String carrinhoJson = jsonEncode(_itens.map((item) => item.toJson()).toList());
    await prefs.setString('carrinho_salvo', carrinhoJson);
  }

  void adicionar(Instrumento instrumento) {
    bool jaExiste = _itens.any((item) => item.id == instrumento.id);

    if (!jaExiste) {
      _itens.add(instrumento);
      _salvarNoDispositivo(); // Salva sempre que mudar
    }
  }

  void remover(Instrumento instrumento) {
    _itens.removeWhere((item) => item.id == instrumento.id);
    _salvarNoDispositivo(); // Salva sempre que mudar
  }

  double calcularTotal() {
    return _itens.fold(0, (total, item) => total + item.preco);
  }
}