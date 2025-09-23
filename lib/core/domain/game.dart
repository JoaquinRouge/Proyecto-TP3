class Game {
  String id;
  String name;
  String developer;
  List<String> genres;
  double rating;
  String coverImage;
  String releaseDate;
  List<String> images;

  Game({
    required this.id,
    required this.name,
    required this.developer,
    required this.genres,
    required this.rating,
    required this.coverImage,
    required this.releaseDate,
    required this.images,
  });
}
