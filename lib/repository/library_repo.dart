import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LibraryRepo {
  final _firebase = FirebaseFirestore.instance.collection('biblioteca');

  Future<void> addGame(int gameId) async{
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return await _firebase.doc().set({'gameId': gameId, 'userId': currentUserId});
  }

  Future<void> removeGame(int gameId) async{
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    final querySnapshot = await _firebase
        .where('gameId', isEqualTo: gameId)
        .where('userId', isEqualTo: currentUserId)
        .get();
    for (var doc in querySnapshot.docs) {
      await _firebase.doc(doc.id).delete();
    }
  }

  Future<List<int>?> library() async{
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    final querySnapshot = await _firebase
        .where('userId', isEqualTo: currentUserId)
        .get();

    return querySnapshot.docs.map((doc) => doc['gameId'] as int).toList();
  }

  Future<bool> isGameInLibrary(int gameId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    final querySnapshot = await _firebase
        .where('gameId', isEqualTo: gameId)
        .where('userId', isEqualTo: currentUserId)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

}
