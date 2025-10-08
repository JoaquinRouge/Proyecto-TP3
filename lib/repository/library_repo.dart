import 'package:proyecto_tp3/core/domain/game.dart';

class LibraryRepo {
  static List<Game> library = [];

  static addGameToLibrary(Game game) {
    library.add(game);
  }

  static removeGameFromLibrary(int id) {
    library.removeWhere((game) => game.id == id);
  }
}
