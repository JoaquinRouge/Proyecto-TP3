import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/game.dart';
import 'package:proyecto_tp3/repository/library_repo.dart';

class LibraryNotifier extends StateNotifier<List<Game>> {
  LibraryNotifier() : super([]) {
    loadLibrary();
  }

  loadLibrary() {
    state = List.from(LibraryRepo.library);
  }

  addGameToLibrary(Game game) {
    LibraryRepo.addGameToLibrary(game);
    loadLibrary();
  }

  removeGameFromLibrary(int id) {
    LibraryRepo.removeGameFromLibrary(id);
    loadLibrary();
  }

}

final libraryProvider = StateNotifierProvider<LibraryNotifier, List<Game>>((
  ref,
) {
  return LibraryNotifier();
});
