import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/review.dart';
import 'package:proyecto_tp3/repository/review_repository.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

class ReviewsNotifier extends StateNotifier<AsyncValue<List<Review>>> {
  final ReviewRepository _repository;
  final int _gameId;

  ReviewsNotifier(this._repository, this._gameId)
      : super(const AsyncValue.loading()) {
    loadReviews();
  }

  Future<void> loadReviews() async {
    try {
      final reviews = await _repository.getReviews(_gameId);
      state = AsyncValue.data(reviews);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addReview(double rating, String content, String username) async {
    final review = Review(
      gameId: _gameId,
      rating: rating,
      content: content,
      reviewerUsername: username,
    );
    await _repository.addReview(review);
    await loadReviews();
  }

  Future<void> editReview(String reviewId, double rating, String content, String username) async {
    final review = Review(
      gameId: _gameId,
      rating: rating,
      content: content,
      reviewerUsername: username,
      id: reviewId,
    );
    await _repository.editReview(reviewId, review);
    await loadReviews();
  }

  Future<void> removeReview(String reviewId) async {
    await _repository.removeReview(reviewId);
    await loadReviews();
  }
}

final reviewsProvider =
    StateNotifierProvider.family<ReviewsNotifier, AsyncValue<List<Review>>, int>(
  (ref, gameId) {
    final repo = ref.watch(reviewRepositoryProvider);
    return ReviewsNotifier(repo, gameId);
  },
);
