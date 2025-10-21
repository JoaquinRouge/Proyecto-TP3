import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_tp3/repository/user_repository.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _repo = UserRepository();

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

  Future<void> addGameToLibrary(int gameId) async{
    await _repo.addGameToLibrary(gameId);
  }

  Future<void> removeGameFromLibrary(int gameId) async{
    await _repo.removeGameFromLibrary(gameId);
  }

  Future<List<int>?> getLibrary()async{
    return await _repo.getLibrary();
  }

  Future<bool> isGameInLibrary(int gameId) async {
    final library = await getLibrary();
    if (library == null) return false;
    return library.contains(gameId);
  }
}