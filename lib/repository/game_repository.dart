import 'package:proyecto_tp3/core/domain/game.dart';

class GameRepository {
  static List<Game> games = [
    Game(
      id: 1,
      name: "The Witcher 3: Wild Hunt",
      developer: "CD Projekt Red",
      genres: ["RPG", "Adventure"],
      platforms: [
        "PC",
        "PlayStation 4",
        "PlayStation 5",
        "Xbox One",
        "Nintendo Switch",
      ],
      rating: 3.5,
      coverImage:
          "https://store-images.s-microsoft.com/image/apps.53717.65858607118306853.39ed2a08-df0d-4ae1-aee0-c66ffb783a34.80ba72da-abfb-4af6-81f2-a443d12fb870",
      releaseDate: "2015-05-19",
    ),
    Game(
      id: 2,
      name: "Red Dead Redemption 2",
      developer: "Rockstar Games",
      genres: ["RPG", "Adventure", "Open World"],
      platforms: ["PC", "PlayStation 4", "PlayStation 5", "Xbox One"],
      rating: 4.5,
      coverImage:
          "https://static.wikia.nocookie.net/rdr/images/3/35/ReddeadII.jpg/revision/latest/scale-to-width-down/1200?cb=20180627190017&path-prefix=es",
      releaseDate: "2018-10-26",
    ),
    Game(
      id: 3,
      name: "Batman Arkham Asylum",
      developer: "Rocksteady Studios",
      genres: ["RPG", "Adventure", "Open World"],
      platforms: [
        "PC",
        "PlayStation 3",
        "PlayStation 4",
        "Xbox 360",
        "Xbox One",
      ],
      rating: 4.0,
      coverImage:
          "https://cdn1.epicgames.com/offer/5f7c811695f14b8fa3a8e1ea35713d23/CodeRedemption_ArkhamAsylum-335x440-58065661db02a2f429d50867e130925e1_1200x1600-5dc57284959156b5eece14a18242073d",
      releaseDate: "2009-08-25",
    ),
    Game(
      id: 4,
      name: "The Sims 4",
      developer: "Maxis / Electronic Arts",
      genres: ["Simulation", "Life", "Sandbox"],
      platforms: ["PC", "Mac", "PlayStation 4", "Xbox One"],
      rating: 3.0,
      coverImage:
          "https://cdn1.epicgames.com/offer/2a14cf8a83b149919a2399504e5686a6/SIMS4_EPIC_PORTRAIT-Product-Image_1200x1600_1200x1600-aab8b38d851dbd96bcba41d6507d3a32",
      releaseDate: "2014-09-02",
    ),
  ];
}
