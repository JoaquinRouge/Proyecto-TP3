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

  Future<void> addReview(Review review) async {
    await db.collection('reviews').add(review.toFirestore());
  }

  Future<void> editReview(String reviewId, Review review) async {
    await db.collection('reviews').doc(reviewId).set(review.toFirestore());
  }

  Future<void> removeReview(String reviewId) async {
    await db.collection('reviews').doc(reviewId).delete();
  }
}
