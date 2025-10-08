class Game {
  int id;
  String name;
  String developer;
  List<String> genres;
  List<String> platforms;
  double rating;
  String coverImage;
  String releaseDate;

  Game({
    required this.id,
    required this.name,
    required this.developer,
    required this.genres,
    required this.platforms,
    required this.rating,
    required this.coverImage,
    required this.releaseDate,
  });
}
