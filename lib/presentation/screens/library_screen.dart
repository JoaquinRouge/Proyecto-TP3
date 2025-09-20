import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/appBar.dart';
import 'package:proyecto_tp3/core/components/bottomBar.dart';

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