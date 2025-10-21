import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final db = FirebaseFirestore.instance.collection('usuarios');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> getCurrentUsername() async {
    final user = auth.currentUser;
    if (user == null) return null;

    final doc = await db.doc(user.uid).get();
    if (!doc.exists) return null;

    return doc.data()?['username'] as String?;
  }

  Future<void> addGameToLibrary(int gameId) async {
    final userId = auth.currentUser?.uid;

    await db.doc(userId).set({
      'library': FieldValue.arrayUnion([gameId]),
    }, SetOptions(merge: true));
  }

  Future<void> removeGameFromLibrary(int gameId) async {
    final userId = auth.currentUser?.uid;

    await db.doc(userId).set({
      'library': FieldValue.arrayRemove([gameId]),
    });
  }

  Future<List<int>?> getLibrary() async {
    final userId = auth.currentUser?.uid;
    if (userId == null) return null;

    final doc = await db.doc(userId).get();
    if (!doc.exists) return null;

    final data = doc.data();
    if (data == null || data['library'] == null) return null;

    final List<dynamic> rawList = data['library'];
    final library = rawList.map((e) => e as int).toList();

    return library;
  }
}
