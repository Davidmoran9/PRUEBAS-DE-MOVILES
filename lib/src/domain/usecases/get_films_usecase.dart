import '../entities/film_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetFilmsUseCase {
  final BaseRepository repository;

  GetFilmsUseCase(this.repository);

  Future<List<FilmEntity>> call() {
    return repository.getFilms();
  }
}