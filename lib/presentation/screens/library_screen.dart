import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/provider/library_provider.dart';
import 'package:proyecto_tp3/widget/game_card.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(libraryProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: "Mis Juegos"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: library.isNotEmpty ? library.map((game) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GameCard(
                  game: game,
                ),
              );
            }).toList() : [
              Center(
                child: Text(
                  "La Biblioteca esta vacía.",
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
