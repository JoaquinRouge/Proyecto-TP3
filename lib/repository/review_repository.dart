import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_tp3/core/domain/review.dart';

class ReviewRepository {
  final db = FirebaseFirestore.instance;

  Future<List<Review>> getReviews(int gameId) async {
    final snapshot = await db
        .collection('reviews')
        .where('gameId', isEqualTo: gameId)
        .get();

    return snapshot.docs
        .map((doc) => Review.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<List<Review>> getReviewsByUser(String reviewerUsername) async {
    final snapshot = await db
        .collection('reviews')
        .where('reviewerUsername', isEqualTo: reviewerUsername)
        .get();

    return snapshot.docs
        .map((doc) => Review.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<Review?> getPersonalReview(int gameId, String reviewerUsername) async {
    final snapshot = await db
        .collection("reviews")
        .where('gameId', isEqualTo: gameId)
        .where('reviewerUsername', isEqualTo: reviewerUsername)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final doc = snapshot.docs.first;

    return Review.fromFirestore(doc.id, doc.data());
  }

  Future<void> addReview(Review review) async {
    await db.collection('reviews').add(review.toFirestore());
  }

  Future<void> editReview(
    String reviewId,
    double rating,
    String content,
  ) async {
    await db.collection('reviews').doc(reviewId).update({
      'rating': rating,
      'content': content,
    });
  }

  Future<void> removeReview(String reviewId) async {
    await db.collection('reviews').doc(reviewId).delete();
  }
}
