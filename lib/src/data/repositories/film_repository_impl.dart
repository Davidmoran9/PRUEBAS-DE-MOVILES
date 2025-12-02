import '../../domain/entities/film_entity.dart';
import '../datasources/base_datasource.dart';
import 'base_repository.dart';

class FilmRepositoryImpl implements BaseRepository {
  final BaseDataSource ds;

  FilmRepositoryImpl(this.ds);

  @override
  Future<List<FilmEntity>> getFilms() {
    return ds.fetchFilms();
  }

  @override
  Future<FilmEntity> getFilmById(String id) {
    return ds.getFilm(id);
  }
}