import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/provider/user_provider.dart';

// Providers para los TextEditingController
final usernameControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  return TextEditingController();
});

final emailControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController();
  // Inicializamos con el email actual
  controller.text = FirebaseAuth.instance.currentUser?.email ?? '';
  return controller;
});

final newPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      return TextEditingController();
    });

final confirmPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      return TextEditingController();
    });

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  Widget customTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
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
    final newPasswordController = ref.watch(newPasswordControllerProvider);
    final confirmPasswordController = ref.watch(
      confirmPasswordControllerProvider,
    );

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
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            customTextField(
              controller: emailController,
              hint: 'Ingrese su email',
            ),
            const SizedBox(height: 20),
            const Text(
              'Usuario',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
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
            const SizedBox(height: 20),
            const Text(
              'Nueva contraseña',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            customTextField(
              controller: newPasswordController,
              hint: 'Ingrese su nueva contraseña',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Confirmar contraseña',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            customTextField(
              controller: confirmPasswordController,
              hint: 'Confirme su nueva contraseña',
              obscureText: true,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final newUsername = usernameController.text.trim();
                final newEmail = emailController.text.trim();
                final newPassword = newPasswordController.text.trim();
                final confirmPassword = confirmPasswordController.text.trim();

                if (newUsername.isEmpty || newEmail.isEmpty) return;

                if (newPassword.isNotEmpty) {
                  if (newPassword != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no coinciden'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                }

                final userService = ref.read(userServiceProvider);

                try {
                  await userService.updateUsername(newUsername);

                  if (newPassword.isNotEmpty) {
                    await userService.updatePassword(newPassword);
                  }
                  // Refrescamos el provider que muestra el username actual
                  ref.invalidate(usernameProvider);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perfil actualizado correctamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.go('/profile');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'requires-recent-login') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Por seguridad, vuelve a iniciar sesión para cambiar datos sensibles.',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    // Aca podés guiar al usuario a volver a loguearse
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message ?? 'Error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
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
