class Review {
  Review({
    required this.gameId,
    required this.reviewerUsername,
    required this.rating,
    required this.content,
    this.id,
  });

  final String? id; // id del documento en Firestore
  final int gameId;
  final String reviewerUsername;
  final double rating;
  final String content;

  factory Review.fromFirestore(String id, Map<String, dynamic> data) {
    return Review(
      id: id,
      gameId: data['gameId'],
      reviewerUsername: data['reviewerUsername'],
      rating: (data['rating'] ?? 0).toDouble(),
      content: data['content'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'gameId': gameId,
      'reviewerUsername': reviewerUsername,
      'rating': rating,
      'content': content,
    };
  }
}
