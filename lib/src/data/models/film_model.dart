import '../../domain/entities/film_entity.dart';

class FilmModel extends FilmEntity {
  FilmModel({
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.originalTitleRomanised,
    required super.description,
    required super.director,
    required super.producer,
    required super.releaseDate,
    required super.runningTime,
    required super.rtScore,
    required super.people,
    required super.species,
    required super.locations,
    required super.vehicles,
    required super.url,
  });

  // Convertir JSON en objeto
  factory FilmModel.fromJson(Map<String, dynamic> json) {
    return FilmModel(
      id: json["id"]?.toString() ?? '',
      title: json["title"]?.toString() ?? 'Sin título',
      originalTitle: json["original_title"]?.toString() ?? '',
      originalTitleRomanised: json["original_title_romanised"]?.toString() ?? '',
      description: json["description"]?.toString() ?? 'Sin descripción',
      director: json["director"]?.toString() ?? 'Director desconocido',
      producer: json["producer"]?.toString() ?? 'Productor desconocido',
      releaseDate: json["release_date"]?.toString() ?? '0',
      runningTime: _parseInt(json["running_time"]),
      rtScore: json["rt_score"]?.toString() ?? '0',
      people: _parseList(json["people"]),
      species: _parseList(json["species"]),
      locations: _parseList(json["locations"]),
      vehicles: _parseList(json["vehicles"]),
      url: json["url"]?.toString() ?? '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static List<String> _parseList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }
}