import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/review.dart';
import 'package:proyecto_tp3/provider/user_provider.dart';
import 'package:proyecto_tp3/repository/review_repository.dart';

class ReviewsNotifier extends StateNotifier<AsyncValue<List<Review>>> {
  final ReviewRepository _repository;
  final int _gameId;
  final Ref ref;

  ReviewsNotifier(this._repository, this._gameId, this.ref)
    : super(const AsyncValue.loading()) {
    loadReviews();
  }

  Future<void> loadReviews() async {
    try {
      final reviews = await _repository.getReviews(_gameId);

      final username = await Future.value(ref.read(usernameProvider).value);

        final userReviewIndex = reviews.indexWhere(
          (r) => r.reviewerUsername == username,
        );

        if (userReviewIndex != -1) {
          final userReview = reviews.removeAt(userReviewIndex);
          reviews.insert(0, userReview);
      }

      state = AsyncValue.data(reviews);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<Review?> getPersonalReview(String username) async {
    try {
      final personalReview = await _repository.getPersonalReview(
        _gameId,
        username,
      );
      return personalReview;
    } catch (e) {
      return null;
    }
  }

  Future<void> addReview(double rating, String content) async {
    final usernameAsync = ref.read(usernameProvider);
    final username = usernameAsync.value;

    if (username == null) {
      throw Exception('Username is not available');
    }

    final review = Review(
      gameId: _gameId,
      rating: rating,
      content: content,
      reviewerUsername: username,
    );
    await _repository.addReview(review);
    await loadReviews();
    ref.invalidate(personalReviewProvider(_gameId));
  }

  Future<void> editReview(
    String reviewId,
    double rating,
    String content,
  ) async {
    await _repository.editReview(reviewId, rating, content);
    await loadReviews();
    ref.invalidate(personalReviewProvider(_gameId));
  }

  Future<void> removeReview(String reviewId) async {
    await _repository.removeReview(reviewId);
    await loadReviews();
    ref.invalidate(personalReviewProvider(_gameId));
  }
}

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository();
});

final reviewsProvider =
    StateNotifierProvider.family<
      ReviewsNotifier,
      AsyncValue<List<Review>>,
      int
    >((ref, gameId) {
      final repo = ref.watch(reviewRepositoryProvider);
      return ReviewsNotifier(repo, gameId, ref);
    });

final personalReviewProvider = FutureProvider.family<Review?, int>((
  ref,
  gameId,
) async {
  final username = ref.watch(usernameProvider).value;
  if (username == null) return null;

  return await ref
      .read(reviewRepositoryProvider)
      .getPersonalReview(gameId, username);
});

final userReviewsProvider = FutureProvider.family<List<Review>, String>((ref, reviewerUsername) async {
  final repo = ref.watch(reviewRepositoryProvider);
  return await repo.getReviewsByUser(reviewerUsername);
});

