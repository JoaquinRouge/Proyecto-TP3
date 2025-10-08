import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/core/components/game_card.dart';
import 'package:proyecto_tp3/provider/library_provider.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(libraryProvider);
    final libraryNotifier = ref.read(libraryProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(title: "Mis Juegos"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: library.map((game) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GameCard(
                  game: game,
                ),
              );
            }).toList(), // 👈 conversión a lista obligatoria
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
