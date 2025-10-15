import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> getCurrentUsername() async {
    final user = auth.currentUser;
    if (user == null) return null;

    final doc = await db.collection('usuarios').doc(user.uid).get();
    if (!doc.exists) return null;

    return doc.data()?['username'] as String?;
  }
}
