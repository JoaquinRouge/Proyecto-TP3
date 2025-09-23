import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/appBar.dart';
import 'package:proyecto_tp3/core/components/bottomBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Home"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
          children: [
            Text('Bienvenido de nuevo,', style: TextStyle(color: Colors.white)),
            Padding(
              padding: EdgeInsets.only(left: 5), // mueve el texto a la derecha
              child: Text(
                "Usuario",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
