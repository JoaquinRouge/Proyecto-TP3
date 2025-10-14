import 'dart:convert';

import 'package:proyecto_tp3/core/domain/game.dart';
import 'package:http/http.dart' as http;

class GameRepository {
  final String baseUrl = 'https://api.rawg.io/api';
  final String apiKey = '56346f811bce4b7d9f94cf840bb4a266';

  Future<List<Game>> fetchGames() async {
    final url = Uri.parse('$baseUrl/games?key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener juegos: ${response.statusCode}');
    }
  }

  Future<List<Game>> fetchGamesByName(String name) async {
    final url = Uri.parse('$baseUrl/games?key=$apiKey&search=$name&page_size=15');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener juegos: ${response.statusCode}');
    }
  }

  Future<List<Game>> fetchStrategy() async {
    final url = Uri.parse(
      '$baseUrl/games?key=$apiKey&genres=strategy&page_size=10',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener juegos: ${response.statusCode}');
    }
  }

  Future<Game> fetchGameDetails(int id) async {
    final url = Uri.parse('$baseUrl/games/$id?key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Game.fromJson(data);
    } else {
      throw Exception(
        'Error al obtener detalles del juego: ${response.statusCode}',
      );
    }
  }
}
