import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/instrumento_model.dart';

class ApiService {
  final String baseUrl = "https://api-instrumentos.onrender.com/instrumentos";

  // GET - Listar todos
  Future<List<Instrumento>> buscarTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> dados = jsonDecode(response.body);
      return dados.map((json) => Instrumento.fromJson(json)).toList();
    } else {
      throw Exception("Falha ao carregar API Restful");
    }
  }

  // POST - Criar novo
  Future<bool> criarInstrumento(Instrumento item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 201;
  }

  // PUT - Atualizar dados
  Future<bool> atualizarInstrumento(String id, Instrumento item) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 200;
  }

  // DELETE - Deletar registro
  Future<bool> deletarInstrumento(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    return response.statusCode == 200;
  }
}
