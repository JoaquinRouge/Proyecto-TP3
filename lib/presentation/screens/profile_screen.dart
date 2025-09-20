import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/appBar.dart';
import 'package:proyecto_tp3/core/components/bottomBar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Profile"),
      body: Center(
        child: Text('Bienvenido a la pantalla de perfil'),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}