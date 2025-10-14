import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/game.dart';
import 'package:proyecto_tp3/repository/game_repository.dart';

class GamesNotifier extends StateNotifier<AsyncValue<List<Game>>> {
  final GameRepository repository;

  GamesNotifier(this.repository) : super(const AsyncValue.loading());

  Future<void> loadGames() async {
    try {
      final games = await repository.fetchGames();
      state = AsyncValue.data(games);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> searchGames(String name) async {
    try {
      final games = await repository.fetchGamesByName(name);
      state = AsyncValue.data(games);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadStrategy() async {
    try {
      final games = await repository.fetchStrategy();
      state = AsyncValue.data(games);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

    Future<void> singleGame(int id) async {
    try {
      final game = await repository.fetchGameDetails(id);
      final games = [game];
      state = AsyncValue.data(games);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final gamesProvider =
    StateNotifierProvider<GamesNotifier, AsyncValue<List<Game>>>((ref) {
      final repo = GameRepository();
      return GamesNotifier(repo)..loadGames();
    });

final searchGamesProvider =
    StateNotifierProvider.family<GamesNotifier, AsyncValue<List<Game>>, String>(
  (ref, query) {
    final repo = GameRepository();
    final notifier = GamesNotifier(repo);
    notifier.searchGames(query); // le pasamos la query
    return notifier;
  },
);

final mostRatedProvider =
    StateNotifierProvider<GamesNotifier, AsyncValue<List<Game>>>((ref) {
      final repo = GameRepository();
      return GamesNotifier(repo)..loadStrategy();
    });
    
final singleGameProvider = StateNotifierProvider.family<GamesNotifier, AsyncValue<List<Game>>, int>(
  (ref, gameId) {
    final repo = GameRepository();
    final notifier = GamesNotifier(repo);
    notifier.singleGame(gameId); // le pasamos el ID
    return notifier;
  },
);
