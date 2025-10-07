import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/game.dart';
import 'package:proyecto_tp3/repository/game_repository.dart';

class GamesNotifier extends StateNotifier<List<Game>> {
  GamesNotifier() : super([]) {
    loadGames();
  }

  loadGames() {
    state = GameRepository.games;
  }
}

final gamesProvider = StateNotifierProvider<GamesNotifier, List<Game>>((ref) {
  return GamesNotifier();
});
