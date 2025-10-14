import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/review.dart';
import 'package:proyecto_tp3/repository/review_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';








/// Provider global del repositorio de reseñas.
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

/// Notifier que usa el repositorio para manejar reseñas.
class ReviewsNotifier extends StateNotifier<List<Review>> {

  final db = FirebaseFirestore.instance;

  final ReviewRepository _repository;
  final int _gameId;

  ReviewsNotifier(this._repository, this._gameId)
      : super(_repository.getReviews(_gameId));

  void addReview(double rating, String content) {
    final review = Review(rating: rating, content: content, reviewerUsername: "pepe");
    _repository.addReview(_gameId, review);
    state = _repository.getReviews(_gameId);
  }

  void editReview(int index, double rating, String text) {
    final review = Review(rating: rating, content: text, reviewerUsername: "pepe");
    _repository.editReview(_gameId, index, review);
    state = _repository.getReviews(_gameId);
  }

  void removeReview(int index) {
    _repository.removeReview(_gameId, index);
    state = _repository.getReviews(_gameId);
  }
}

/// Provider por juego que inyecta el repositorio.
final reviewsProvider =
    StateNotifierProvider.family<ReviewsNotifier, List<Review>, int>(
  (ref, gameId) {
    final repo = ref.watch(reviewRepositoryProvider);
    return ReviewsNotifier(repo, gameId);
  },
);
