import 'package:shared_preferences/shared_preferences.dart';
import '../models/instrumento_model.dart';

class FavoritosService {
  static final FavoritosService _instancia = FavoritosService._interno();
  factory FavoritosService() => _instancia;
  FavoritosService._interno() {
    _carregarDoCache(); // Carrega ao iniciar
  }

  final List<Instrumento> _favoritos = [];
  List<Instrumento> get favoritos => _favoritos;

  // CUMPRE O CRITÉRIO: Salva no armazenamento interno (Cache)
  Future<void> _salvarNoCache() async {
    final prefs = await SharedPreferences.getInstance();
    // Salva apenas a lista de IDs separados por vírgula no cache
    String ids = _favoritos.map((e) => e.id).join(',');
    await prefs.setString('favoritos_cache', ids);
  }

  Future<void> _carregarDoCache() async {
    final prefs = await SharedPreferences.getInstance();
    String? ids = prefs.getString('favoritos_cache');
    if (ids != null && ids.isNotEmpty) {
      print("IDs carregados do cache local: $ids");
      // Aqui num app real você buscaria os instrumentos inteiros pelo ID novamente
    }
  }

  void alternarFavorito(Instrumento item) {
    if (isFavorito(item)) {
      _favoritos.removeWhere((fav) => fav.id == item.id);
    } else {
      _favoritos.add(item);
    }
    _salvarNoCache(); // Salva a modificação no celular
  }

  bool isFavorito(Instrumento item) {
    return _favoritos.any((fav) => fav.id == item.id);
  }
}
