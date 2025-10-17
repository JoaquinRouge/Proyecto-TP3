import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/provider/games_provider.dart';
import 'package:proyecto_tp3/provider/user_provider.dart';
import 'package:proyecto_tp3/widget/game_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameAsync = ref.watch(usernameProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: "Home"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              usernameAsync.when(
                data: (username) => Text(
                  'Bienvenido de nuevo, ${username ?? "Usuario"}',
                  style: const TextStyle(color: Colors.white),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => const Text(
                  'Error al cargar usuario',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Recomendados para ti",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              recentlyAdded(context, ref),
              const SizedBox(height: 15),
              const Text(
                "Lo mejor en Estrategia",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              mostRated(context, ref),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}

SingleChildScrollView mostRated(BuildContext context, WidgetRef ref) {
  final gamesAsync = ref.watch(mostRatedProvider);

  return gamesAsync.when(
    data: (games) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: games.map((game) {
          return GameCard(game: game);
        }).toList(),
      ),
    ),
    loading: () => const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(child: CircularProgressIndicator()),
    ),
    error: (error, stack) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(child: Text('Error: $error')),
    ),
  );
}

SingleChildScrollView recentlyAdded(BuildContext context, WidgetRef ref) {
  final gamesAsync = ref.watch(gamesProvider);

  return gamesAsync.when(
    data: (games) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: games.map((game) {
          return GameCard(game: game);
        }).toList(),
      ),
    ),
    loading: () => const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(child: CircularProgressIndicator()),
    ),
    error: (error, stack) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(child: Text('Error: $error')),
    ),
  );
}
