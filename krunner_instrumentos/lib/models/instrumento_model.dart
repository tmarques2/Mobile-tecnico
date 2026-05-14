// 1. CLASSE MÃE (Superclasse)
abstract class Produto {
  final String id;
  final String nome;
  final double preco;
  final String imagemUrl;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagemUrl,
  });
}

// 2. SUBCLASSE (Filha que herda de Produto) - CUMPRE O CRITÉRIO DO PDF!
class Instrumento extends Produto {
  final String categoria;

  Instrumento({
    required String id,
    required String nome,
    required double preco,
    required String imagemUrl,
    required this.categoria,
  }) : super(id: id, nome: nome, preco: preco, imagemUrl: imagemUrl); // Passa os dados pra classe mãe

  // Transforma de JSON para Objeto
  factory Instrumento.fromJson(Map<String, dynamic> json) {
    return Instrumento(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      preco: (json['preco'] ?? 0).toDouble(),
      imagemUrl: json['imagemUrl'] ?? '',
      categoria: json['categoria'] ?? '',
    );
  }

  // Transforma de Objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'imagemUrl': imagemUrl,
      'categoria': categoria,
    };
  }
}