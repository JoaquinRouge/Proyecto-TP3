import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/provider/games_provider.dart';
import 'package:proyecto_tp3/widget/game_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenido de nuevo, @Usuario',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 15),
              Text(
                "Recomendados para ti",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              recentlyAdded(context, ref),
              SizedBox(height: 15),
              Text(
                "Lo mejor en Estrategia",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              mostRated(context, ref),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        onPressed: () {
          GoRouter.of(context).go('/add_game');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  SingleChildScrollView mostRated(BuildContext context, WidgetRef ref) {
    final gamesAsync = ref.watch(mostRatedProvider);

    return gamesAsync.when(
      data: (games) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: games.map((game) {
            return GameCard(game:game);
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
}
