import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/instrumento_model.dart';

class FavoritosService {
  static final FavoritosService _instance = FavoritosService._internal();
  factory FavoritosService() => _instance;
  FavoritosService._internal();

  final List<Instrumento> _favoritos = [];
  List<Instrumento> get favoritos => _favoritos;

  // Carrega os favoritos salvos no dispositivo
  Future<void> carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritosJson = prefs.getString('favoritos_salvos');
    
    if (favoritosJson != null) {
      final List<dynamic> dadosDecodificados = jsonDecode(favoritosJson);
      _favoritos.clear();
      _favoritos.addAll(
        dadosDecodificados.map((item) => Instrumento.fromJson(item)).toList()
      );
    }
  }

  // Salva o estado atual dos favoritos no dispositivo
  Future<void> _salvarNoDispositivo() async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritosJson = jsonEncode(_favoritos.map((item) => item.toJson()).toList());
    await prefs.setString('favoritos_salvos', favoritosJson);
  }

  bool isFavorito(Instrumento instrumento) {
    return _favoritos.any((item) => item.id == instrumento.id);
  }

  void alternarFavorito(Instrumento instrumento) {
    if (isFavorito(instrumento)) {
      _favoritos.removeWhere((item) => item.id == instrumento.id);
    } else {
      _favoritos.add(instrumento);
    }
    _salvarNoDispositivo(); // Salva após alternar
  }
}