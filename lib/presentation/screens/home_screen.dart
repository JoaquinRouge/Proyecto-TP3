import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/core/components/game_card.dart';
import 'package:proyecto_tp3/provider/games_provider.dart';
import 'package:proyecto_tp3/provider/library_provider.dart';
import 'package:proyecto_tp3/repository/game_repository.dart';

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
                'Bienvenido de nuevo, Usuario',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 15),
              Text(
                "Recien Agregados",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              recentlyAdded(ref),
              SizedBox(height: 15),
              Text(
                "Los Mas Valorados",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              recentlyAdded(ref),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }

  SingleChildScrollView recentlyAdded(WidgetRef ref) {
    final games = ref.watch(gamesProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: games.map((game) {
          return GameCard(game: game);
        }).toList(),
      ),
    );
  }
}
