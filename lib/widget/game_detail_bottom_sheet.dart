import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:proyecto_tp3/core/domain/game.dart';
import 'package:proyecto_tp3/core/domain/review.dart';
import 'package:proyecto_tp3/provider/games_provider.dart';
import 'package:proyecto_tp3/provider/library_provider.dart';
import 'package:proyecto_tp3/provider/review_provider.dart';
import 'package:proyecto_tp3/widget/add_review_bottom_sheet.dart';
import 'package:proyecto_tp3/widget/review_card.dart';

class GameDetailBottomSheet extends ConsumerWidget {
  const GameDetailBottomSheet({super.key, required this.gameId});

  final int gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(singleGameProvider(gameId));
    final library = ref.watch(libraryProvider);
    final libraryNotifier = ref.read(libraryProvider.notifier);

    return gameAsync.when(
      data: (games) {
        if (games.isEmpty) {
          return const Center(child: Text('Juego no encontrado'));
        }

        final game = games[0];
        final isInLibrary = library.any((g) => g.id == game.id);
        final reviewsAsync = ref.watch(reviewsProvider(game.id));

        return DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const HeroIcon(
                              HeroIcons.chevronDown,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Text(
                              game.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                      Divider(color: Colors.grey[300], thickness: 0.2),
                      gameInfo(ref, game, isInLibrary, context, () {
                        if (isInLibrary) {
                          libraryNotifier.removeGameFromLibrary(game.id);
                        } else {
                          libraryNotifier.addGameToLibrary(game);
                        }
                      }),
                      reviewsAsync.when(
                        data: (reviews) => gameReviews(context, game, reviews),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, st) => Center(child: Text('Error: $e')),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Padding gameReviews(BuildContext context, Game game, List<Review> reviews) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reseñas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: ReviewBottomSheet(gameId: game.id),
                      ),
                    );
                  },
                  child: const Text("Agregar Reseña"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          if (reviews.isEmpty)
            const Text(
              'No hay reseñas aún',
              style: TextStyle(color: Colors.grey),
            ),
          ...reviews.asMap().entries.map((entry) {
            return ReviewCard(
              review: entry.value,
              index: entry.key,
              gameId: game.id,
              reviewerUsername: entry.value.reviewerUsername,
            );
          }),
        ],
      ),
    );
  }

  Padding gameInfo(
    WidgetRef ref,
    Game game,
    bool isInLibrary,
    BuildContext context,
    void Function() onToggleLibrary,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          gameImage(game),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  game.name,
                  maxLines: 2,
                  softWrap: true,
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
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: GestureDetector(
                  key: ValueKey(isInLibrary),
                  onTap: () {
                    onToggleLibrary();
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isInLibrary
                              ? 'Juego removido de la biblioteca'
                              : 'Juego añadido a la biblioteca',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            isInLibrary ? Colors.red : Colors.green,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
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
          Row(children: buildStars(game.rating)),
          const SizedBox(height: 20),
          Row(
            children: [
              const HeroIcon(HeroIcons.tag, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  game.genres.join(", "),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const HeroIcon(HeroIcons.tv, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  game.platforms.join(", "),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const HeroIcon(HeroIcons.calendar, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                game.releaseDate.replaceAll("-", "/"),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const HeroIcon(HeroIcons.buildingLibrary, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                game.developer,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Center gameImage(Game game) {
    return Center(
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
    );
  }
}

List<Widget> buildStars(double rating) {
  List<Widget> stars = [];
  int fullStars = rating.floor();
  bool hasHalf = (rating - fullStars) >= 0.5;

  for (int i = 0; i < fullStars; i++) {
    stars.add(const Icon(Icons.star, color: Colors.amber, size: 30));
  }

  if (hasHalf) {
    stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 30));
  }

  while (stars.length < 5) {
    stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 30));
  }

  stars.add(const SizedBox(width: 8));

  return stars;
}
