import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:proyecto_tp3/core/domain/game.dart';
import 'package:proyecto_tp3/provider/library_provider.dart';
import 'package:proyecto_tp3/provider/review_provider.dart';
import 'package:proyecto_tp3/widget/add_review_button.dart';
import 'package:proyecto_tp3/widget/review_card.dart';

class GameDetailPage extends ConsumerWidget {
  final Game game;
  const GameDetailPage({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(libraryProvider);
    final libraryNotifier = ref.read(libraryProvider.notifier);
    final isInLibrary = library.any((g) => g.id == game.id);

    final reviews = ref.watch(reviewsProvider(game.id));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const HeroIcon(HeroIcons.chevronLeft, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          game.name,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      floatingActionButton: AddReviewButton(gameId: game.id),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del juego
            Center(
              child: SizedBox(
                width: 250,
                height: 300,
                child: Image.network(
                  game.coverImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 80, color: Colors.grey);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nombre y botón agregar/remover
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    game.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                  child: GestureDetector(
                    key: ValueKey(isInLibrary),
                    onTap: () {
                      if (isInLibrary) {
                        libraryNotifier.removeGameFromLibrary(game.id);
                      } else {
                        libraryNotifier.addGameToLibrary(game);
                      }

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isInLibrary
                                ? 'Juego removido de la biblioteca'
                                : 'Juego añadido a la biblioteca',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: isInLibrary ? Colors.red : Colors.green,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: HeroIcon(
                      isInLibrary ? HeroIcons.minusCircle : HeroIcons.plusCircle,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Rating
            Row(children: buildStars(game.rating)),
            const SizedBox(height: 20),

            // Géneros, Plataformas, Fecha y Desarrollador
            ..._gameInfo(game),

            const SizedBox(height: 30),
            Text('Reseñas', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            if (reviews.isEmpty)
              const Text('No hay reseñas aún', style: TextStyle(color: Colors.grey)),
            ...reviews.asMap().entries.map((entry) {
              return ReviewCard(review: entry.value, index: entry.key, gameId: game.id);
            }).toList(),
          ],
        ),
      ),
    );
  }

  List<Widget> _gameInfo(Game game) {
    return [
      _infoRow(HeroIcons.tag, game.genres.join(", ")),
      const SizedBox(height: 15),
      _infoRow(HeroIcons.tv, game.platforms.join(", ")),
      const SizedBox(height: 15),
      _infoRow(HeroIcons.calendar, game.releaseDate.replaceAll("-", "/")),
      const SizedBox(height: 15),
      _infoRow(HeroIcons.buildingLibrary, game.developer),
      const SizedBox(height: 15),
    ];
  }

  Widget _infoRow(HeroIcons icon, String text) {
    return Row(
      children: [
        HeroIcon(icon, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

// Función para convertir rating en estrellas
List<Widget> buildStars(double rating) {
  List<Widget> stars = [];
  int fullStars = rating.floor();
  bool hasHalf = (rating - fullStars) >= 0.5;

  for (int i = 0; i < fullStars; i++) {
    stars.add(const Icon(Icons.star, color: Colors.amber, size: 30));
  }

  if (hasHalf) stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 30));

  while (stars.length < 5) {
    stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 30));
  }

  stars.add(const SizedBox(width: 8));
  return stars;
}
