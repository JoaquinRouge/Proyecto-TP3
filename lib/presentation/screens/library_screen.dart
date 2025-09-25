import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Mis Juegos"),
      body: Center(
        child: Text('Bienvenido a la pantalla de biblioteca'),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}