import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_tp3/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository(this._firebaseAuthService);

  Future<User?> login(String email, String password) =>
      _firebaseAuthService.login(email, password);

  Future<User?> register(String email, String password) =>
      _firebaseAuthService.register(email, password);

  Future<void> logout() => _firebaseAuthService.logout();

  User? get currentUser => _firebaseAuthService.currentUser;
}
