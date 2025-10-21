import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/repository/user_repository.dart';
import 'package:proyecto_tp3/services/user_service.dart';


final usernameProvider = FutureProvider<String?>((ref) async {
  final repo = UserRepository();
  return await repo.getCurrentUsername();
});

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

