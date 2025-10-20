import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/provider/user_provider.dart';

// Providers para los TextEditingController
final usernameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final emailControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  // Inicializamos con el email actual
  controller.text = FirebaseAuth.instance.currentUser?.email ?? '';
  return controller;
});

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  Widget customTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameAsync = ref.watch(usernameProvider);
    final usernameController = ref.watch(usernameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: 'Editar Perfil'),
      bottomNavigationBar: const CustomBottomBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10),
            customTextField(
              controller: emailController,
              hint: 'Ingrese su email',
            ),
            const SizedBox(height: 20),

            const Text(
              'Usuario',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10),

            usernameAsync.when(
              data: (username) {
                usernameController.text = username.toString();
                return customTextField(
                  controller: usernameController,
                  hint: 'Ingrese su nombre de usuario',
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text(
                'Error: $err',
                style: const TextStyle(color: Colors.red),
              ),
            ),

            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => context.go('/profile'),
              child: const Text(
                'Volver al perfil',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                final newUsername = usernameController.text.trim();
                final newEmail = emailController.text.trim();
                if (newUsername.isEmpty || newEmail.isEmpty) return;

                final userService = ref.read(userServiceProvider);
                await userService.updateUsername(newUsername);
                //await userService.updateEmail(newEmail);

                // Refrescamos el provider que muestra el username actual
                ref.invalidate(usernameProvider);

                context.go('/profile');
              },
              child: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
