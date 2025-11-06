import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/core/components/dialogs/logout_dialog.dart';
import 'package:proyecto_tp3/provider/page_provider.dart';
import 'package:proyecto_tp3/services/firebase_auth_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: const CustomAppBar(title: "Perfil"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: db.collection('usuarios').doc(uid).get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data = snapshot.data!.data() as Map<String, dynamic>?;
                    final userPhotoUrl = data?['photoUrl'];
                    final username = data?['username'] ?? "Usuario";

                    return Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.grey[800],
                              backgroundImage: userPhotoUrl != null
                                  ? NetworkImage(userPhotoUrl)
                                  : null,
                              child: userPhotoUrl == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 100,
                                      color: Colors.white70,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  user?.email ?? "Correo no disponible",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 60),

                // Botón Ver Mis Reseñas
                ElevatedButton(
                  onPressed: () {
                    context.push('/user_reviews');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Ver Mis Reseñas",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Botón Editar Perfil
                ElevatedButton(
                  onPressed: () {
                    context.push('/edit_profile');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Editar perfil",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    final confirm = await LogoutDialog.show(context);
                    if (confirm == true) {
                      await FirebaseAuthService().logout();
                      ref.invalidate(pageProvider);
                      if (context.mounted) {
                        context.go('/login');
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Cerrar sesión",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
