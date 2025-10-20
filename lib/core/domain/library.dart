class Library {
  Library({required this.gameId, required this.userId});

  final String gameId;
  final String userId;

  factory Library.fromFirestore(String gameId, String userId) {
    return Library(
      gameId: gameId,
      userId: userId,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'gameId': gameId,
      'userId': userId,
    };
  }
}
