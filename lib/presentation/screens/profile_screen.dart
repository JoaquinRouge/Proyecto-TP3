import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/bottomBar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bienvenido a la pantalla de perfil'),
      ),
      bottomNavigationBar: CustomBottomBar(currentRoute: "/profile",),
    );
  }
}