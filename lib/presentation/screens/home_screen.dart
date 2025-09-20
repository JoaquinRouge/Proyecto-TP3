import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/bottomBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bienvenido a la pantalla de inicio'),
      ),
      bottomNavigationBar: CustomBottomBar(currentRoute: "/home",),
    );
  }
}