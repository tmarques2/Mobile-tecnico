import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/instrumento_model.dart';

class ItemCarrinho {
  final Instrumento instrumento;
  int quantidade;

  ItemCarrinho({required this.instrumento, this.quantidade = 1});

  Map<String, dynamic> toJson() => {
    'instrumento': instrumento.toJson(),
    'quantidade': quantidade,
  };

  factory ItemCarrinho.fromJson(Map<String, dynamic> json) => ItemCarrinho(
    instrumento: Instrumento.fromJson(json['instrumento']),
    quantidade: json['quantidade'],
  );
}

class CarrinhoService {
  static final CarrinhoService _instance = CarrinhoService._internal();
  factory CarrinhoService() => _instance;
  CarrinhoService._internal();

  final Map<String, ItemCarrinho> _itensMap = {};

  // Retorna uma lista simples para a tela continuar funcionando parecida
  List<ItemCarrinho> get itens => _itensMap.values.toList();

  // Calcula o total multiplicando o preço pela quantidade de cada item
  double get total => _itensMap.values.fold(
    0,
    (total, item) => total + (item.instrumento.preco * item.quantidade),
  );

  Future<void> carregarCarrinho() async {
    final prefs = await SharedPreferences.getInstance();
    final String? carrinhoJson = prefs.getString('carrinho_salvo');

    if (carrinhoJson != null) {
      final List<dynamic> dadosDecodificados = jsonDecode(carrinhoJson);
      _itensMap.clear();
      for (var item in dadosDecodificados) {
        final itemCarrinho = ItemCarrinho.fromJson(item);
        _itensMap[itemCarrinho.instrumento.id.toString()] = itemCarrinho;
      }
    }
  }

  Future<void> _salvarNoDispositivo() async {
    final prefs = await SharedPreferences.getInstance();
    final String carrinhoJson = jsonEncode(
      _itensMap.values.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('carrinho_salvo', carrinhoJson);
  }

  // Se já existe, aumenta a quantidade. Se não, adiciona no Map.
  void adicionar(Instrumento instrumento) {
    final idStr = instrumento.id.toString();
    if (_itensMap.containsKey(idStr)) {
      _itensMap[idStr]!.quantidade++;
    } else {
      _itensMap[idStr] = ItemCarrinho(instrumento: instrumento);
    }
    _salvarNoDispositivo();
  }

  // Diminui a quantidade. Se chegar a 0, remove do Map.
  void remover(Instrumento instrumento) {
    final idStr = instrumento.id.toString();
    if (_itensMap.containsKey(idStr)) {
      if (_itensMap[idStr]!.quantidade > 1) {
        _itensMap[idStr]!.quantidade--;
      } else {
        _itensMap.remove(idStr);
      }
      _salvarNoDispositivo();
    }
  }

  // Remove o produto inteiramente do carrinho, ignorando a quantidade
  void deletar(Instrumento instrumento) {
    final idStr = instrumento.id.toString();
    if (_itensMap.containsKey(idStr)) {
      _itensMap.remove(idStr);
      _salvarNoDispositivo();
    }
  }
}
