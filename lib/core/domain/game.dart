class Game {
  final int id;
  final String name;
  final String developer;
  final List<String> genres;
  final List<String> platforms;
  final double rating;
  final String coverImage;
  final String releaseDate;

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

  factory Game.fromJson(Map<String, dynamic> json) {

    double rawRating = (json['rating'] ?? 0).toDouble();
    double roundedRating = (rawRating * 2).round() / 2;

    return Game(
      id: json['id'],
      name: json['name'],
      developer: (json['developers'] != null && (json['developers'] as List).isNotEmpty)
          ? json['developers'][0]['name']
          : 'Desconocido',
      genres: (json['genres'] as List?)?.map((g) => g['name'] as String).toList() ?? [],
      platforms: (json['platforms'] as List?)
              ?.map((p) => p['platform']['name'] as String)
              .toList() ??
          [],
      rating: roundedRating,
      coverImage: json['background_image'] ?? '',
      releaseDate: json['released'] ?? 'Desconocida',
    );
  }
}
