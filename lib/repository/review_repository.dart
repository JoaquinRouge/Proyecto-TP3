import 'package:proyecto_tp3/core/domain/review.dart';

class ReviewRepository {
  final Map<int, List<Review>> _reviewsByGame = {};
  
  List<Review> getReviews(int gameId) {
    return _reviewsByGame[gameId] ?? [];
  }

  void addReview(int gameId, Review review) {
    final reviews = List<Review>.from(_reviewsByGame[gameId] ?? []);
    reviews.add(review);
    _reviewsByGame[gameId] = reviews;
  }

  void editReview(int gameId, int index, Review review) {
    final reviews = List<Review>.from(_reviewsByGame[gameId] ?? []);
    if (index >= 0 && index < reviews.length) {
      reviews[index] = review;
      _reviewsByGame[gameId] = reviews;
    }
  }

  void removeReview(int gameId, int index) {
    final reviews = List<Review>.from(_reviewsByGame[gameId] ?? []);
    if (index >= 0 && index < reviews.length) {
      reviews.removeAt(index);
      _reviewsByGame[gameId] = reviews;
    }
  }
}
