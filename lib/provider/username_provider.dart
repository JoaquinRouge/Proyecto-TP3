import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/repository/user_repository.dart';

final usernameProvider = FutureProvider<String?>((ref) async {
  final repo = UserRepository();
  return await repo.getCurrentUsername();
});
