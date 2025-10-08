import 'package:flutter_riverpod/flutter_riverpod.dart';

// Modelo de reseña
class Review {
  final String content;
  Review({required this.content});
}

// Notifier
class ReviewsNotifier extends StateNotifier<List<Review>> {
  ReviewsNotifier() : super([]);

  void addReview(String text) => state = [...state, Review(content: text)];
  void editReview(int index, String text) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) Review(content: text) else state[i]
    ];
  }

  void removeReview(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
  }
}

// Provider por juego
final reviewsProvider = StateNotifierProvider.family<ReviewsNotifier, List<Review>, int>(
  (ref, gameId) => ReviewsNotifier(),
);
