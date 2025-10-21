import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/provider/games_provider.dart';
import 'package:proyecto_tp3/provider/user_provider.dart';
import 'package:proyecto_tp3/widget/game_card.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(userServiceProvider).getLibrary();

    return Scaffold(
      appBar: const CustomAppBar(title: "Mis Juegos"),
      body: FutureBuilder<List<int>?>(
        future: library,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final gameIds = snapshot.data ?? [];

          if (gameIds.isEmpty) {
            return const Center(
              child: Text(
                "La Biblioteca está vacía.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: gameIds.length,
            itemBuilder: (context, index) {
              final gameId = gameIds[index];

              final gameAsync = ref.watch(singleGameProvider(gameId));

              return gameAsync.when(
                data: (games) {
                  final game = games.first;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GameCard(game: game),
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, stack) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Error al cargar juego ID $gameId",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
