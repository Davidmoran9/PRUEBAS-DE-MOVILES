import '../../domain/entities/film_entity.dart';

abstract class BaseRepository {
  Future<List<FilmEntity>> getFilms();
  Future<FilmEntity> getFilmById(String id);
}