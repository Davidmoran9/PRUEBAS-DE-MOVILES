import '../models/film_model.dart';

abstract class BaseDataSource {
  Future<List<FilmModel>> fetchFilms();
  Future<FilmModel> getFilm(String id);
}