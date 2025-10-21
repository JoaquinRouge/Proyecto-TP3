import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final usernameProvider = FutureProvider<String?>((ref) async {
  final repo = UserRepository();
  return await repo.getCurrentUsername();
});

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

class UserService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> updateUsername(String newUsername) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no logueado');

    await _db.collection('usuarios').doc(uid).update({
      'username': newUsername,
    });
  }

  Future<void> updateEmail(String newEmail) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('Usuario no logueado');

    await user.verifyBeforeUpdateEmail(newEmail);
  }

  Future<String> getUsername() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no logueado');

    final doc = await _db.collection('usuarios').doc(uid).get();
    return doc['username'] ?? '';
  }

  Future<void> updatePassword(String newPassword) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('Usuario no logueado');

    try {
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw FirebaseAuthException(code: 'requires-recent-login', message: 'Debes volver a iniciar sesión para cambiar tu contraseña',);
      } else {
        rethrow;
      }
    }
  }
}
