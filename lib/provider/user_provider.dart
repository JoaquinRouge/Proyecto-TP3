import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final usernameProvider = FutureProvider<String?>((ref) async {
  final userService = ref.watch(userServiceProvider);
  return await userService.getUsername();
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

  Future<String> getUsername() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no logueado');

    final doc = await _db.collection('usuarios').doc(uid).get();
    return doc['username'] ?? '';
  }
}