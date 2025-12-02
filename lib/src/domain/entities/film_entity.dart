class FilmEntity {
  final String id;
  final String title;
  final String originalTitle;
  final String originalTitleRomanised;
  final String description;
  final String director;
  final String producer;
  final String releaseDate;
  final int runningTime;
  final String rtScore;
  final List<String> people;
  final List<String> species;
  final List<String> locations;
  final List<String> vehicles;
  final String url;

  FilmEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalTitleRomanised,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rtScore,
    required this.people,
    required this.species,
    required this.locations,
    required this.vehicles,
    required this.url,
  });
}