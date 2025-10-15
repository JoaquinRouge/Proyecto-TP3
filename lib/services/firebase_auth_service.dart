import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> register(String email, String username, String password) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('username', isEqualTo: username)
        .get();

    final usernameTaken = snapshot.docs.isNotEmpty;

    if (usernameTaken) {
      throw FirebaseAuthException(
        code: 'username-already-in-use',
        message: 'El nombre de usuario ya está en uso.',
      );
    }

    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user!;

    await FirebaseFirestore.instance.collection("usuarios").doc(user.uid).set({
      'uid': user.uid,
      'username': username,
    });

    return result.user;
  }

  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
