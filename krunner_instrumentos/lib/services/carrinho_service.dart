import '../models/instrumento_model.dart';

class CarrinhoService {
  // Padrão Singleton: Garante que exista apenas UM carrinho no app todo
  static final CarrinhoService _instancia = CarrinhoService._interno();
  factory CarrinhoService() => _instancia;
  CarrinhoService._interno();

  final List<Instrumento> _itens = [];

  List<Instrumento> get itens => _itens;

  // Soma o valor total de todos os itens no carrinho
  double get total => _itens.fold(0, (soma, item) => soma + item.preco);

  void adicionar(Instrumento item) {
    _itens.add(item);
  }

  void remover(Instrumento item) {
    _itens.remove(item);
  }
}