import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_datasource.dart';
import '../models/film_model.dart';

class FilmApiDataSource implements BaseDataSource {
  final String baseUrl = "https://ghibliapi.vercel.app/films";

  @override
  Future<List<FilmModel>> fetchFilms() async {
    try {
      final url = Uri.parse(baseUrl);
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw Exception("Error HTTP ${resp.statusCode}: ${resp.body}");
      }

      final List<dynamic> decodedData = json.decode(resp.body);
      
      List<FilmModel> films = [];
      for (var filmData in decodedData) {
        try {
          films.add(FilmModel.fromJson(filmData));
        } catch (e) {
          // Continúa con la siguiente película si hay error en una
          continue;
        }
      }
      
      return films;
    } catch (e) {
      throw Exception("Error al obtener películas: $e");
    }
  }

  @override
  Future<FilmModel> getFilm(String id) async {
    try {
      final url = Uri.parse("$baseUrl/$id");
      final resp = await http.get(url);

      if (resp.statusCode != 200) {
        throw Exception("Error HTTP ${resp.statusCode}: ${resp.body}");
      }

      return FilmModel.fromJson(json.decode(resp.body));
    } catch (e) {
      throw Exception("Error al obtener película: $e");
    }
  }
}