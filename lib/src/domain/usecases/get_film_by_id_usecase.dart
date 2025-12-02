import '../entities/film_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetFilmByIdUseCase {
  final BaseRepository repository;

  GetFilmByIdUseCase(this.repository);

  Future<FilmEntity> call(String id) {
    return repository.getFilmById(id);
  }
}