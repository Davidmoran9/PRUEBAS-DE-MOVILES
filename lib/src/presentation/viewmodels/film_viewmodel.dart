import '../../domain/entities/film_entity.dart';
import '../../domain/usecases/get_films_usecase.dart';
import '../../domain/usecases/get_film_by_id_usecase.dart';
import 'base_viewmodel.dart';

class FilmViewModel extends BaseViewModel {
  final GetFilmsUseCase getFilmsUseCase;
  final GetFilmByIdUseCase getFilmByIdUseCase;

  List<FilmEntity> _allFilms = [];
  List<FilmEntity> films = [];
  FilmEntity? selectedFilm;
  String? errorMessage;

  // Filtros
  String _searchQuery = '';
  String _selectedDirector = '';
  List<String> availableDirectors = [];

  FilmViewModel({
    required this.getFilmsUseCase,
    required this.getFilmByIdUseCase,
  });

  String get searchQuery => _searchQuery;
  String get selectedDirector => _selectedDirector;

  Future<void> cargarFilms() async {
    setLoading(true);
    errorMessage = null;
    try {
      _allFilms = await getFilmsUseCase();
      films = List.from(_allFilms);
      _extractDirectors();
      _applyFilters();
    } catch (e) {
      errorMessage = 'Error al cargar películas: $e';
      films = [];
      _allFilms = [];
    }
    setLoading(false);
  }

  Future<void> cargarFilmPorId(String id) async {
    setLoading(true);
    errorMessage = null;
    try {
      selectedFilm = await getFilmByIdUseCase(id);
    } catch (e) {
      errorMessage = 'Error al cargar película: $e';
      selectedFilm = null;
    }
    setLoading(false);
  }

  void buscarPorTexto(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void filtrarPorDirector(String director) {
    _selectedDirector = director;
    _applyFilters();
    notifyListeners();
  }

  void limpiarFiltros() {
    _searchQuery = '';
    _selectedDirector = '';
    _applyFilters();
    notifyListeners();
  }

  void _extractDirectors() {
    Set<String> directors = {};
    for (var film in _allFilms) {
      directors.add(film.director);
    }
    availableDirectors = directors.toList()..sort();
  }

  void _applyFilters() {
    films = _allFilms.where((film) {
      // Filtro de búsqueda por texto
      bool matchesSearch = _searchQuery.isEmpty ||
          film.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          film.description.toLowerCase().contains(_searchQuery.toLowerCase());

      // Filtro por director
      bool matchesDirector = _selectedDirector.isEmpty ||
          film.director == _selectedDirector;

      return matchesSearch && matchesDirector;
    }).toList();
  }
}