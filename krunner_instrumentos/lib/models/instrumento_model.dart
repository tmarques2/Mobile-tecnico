class Instrumento {
  final String id;
  final String nome;
  final double preco;
  final String imagemUrl;
  final String categoria; // Mantido pois seu catalogo_tela.dart utiliza

  Instrumento({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagemUrl,
    required this.categoria,
  });

  // Converte de JSON (usado na API e no SharedPreferences)
  factory Instrumento.fromJson(Map<String, dynamic> json) {
    return Instrumento(
      id: json['id'] ?? json['_id'] ?? '',
      nome: json['nome'] ?? '',
      preco: (json['preco'] as num?)?.toDouble() ?? 0.0,
      imagemUrl: json['imagemUrl'] ?? json['imagem_url'] ?? '',
      categoria: json['categoria'] ?? '',
    );
  }

  // Converte para JSON (usado para salvar no SharedPreferences)
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