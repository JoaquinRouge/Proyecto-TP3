import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/account.dart';

final accountProvider = StateNotifierProvider<AccountNotifier, Account?>(
  (ref) => AccountNotifier(),
);

class AccountNotifier extends StateNotifier<Account?> {
  AccountNotifier() : super(null);

  final db = FirebaseFirestore.instance;

  /*
  esto no funciona. me estoy volviendo loco nomas
  void registerAccount(Account account) {
    db.collection("users").doc(account.username).set({
      'username': account.username,
      'email': account.email,
      'password': account.password,
    });
  }

  void loginAccount(String username, String password) async {
    final doc = await db.collection("users").doc(username).get();
    if (doc.exists) {
      final data = doc.data()!;
      if (data['password'] == password) {
        state = Account(
          username: data['username'],
          email: data['email'],
          password: data['password'],
        );
      } else {
        throw Exception("Incorrect password");
      }
    } else {
      throw Exception("User not found");
    }
  }

  void updateAccount(Account account) {
    state = account;
  }

  void clearAccount() {
    state = null;
  }*/
}