import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';

class AgregarJuegoPage extends StatelessWidget {
  const AgregarJuegoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: 'Agregar juego'),
      bottomNavigationBar: const CustomBottomBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Título ---
            const Text(
              'Título',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            customTextField('Ej: The Legend of Zelda: Breath of the Wild'),

            const SizedBox(height: 16),
            const Text(
              'Género',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            customTextField('Ej: Aventura, RPG'),

            const SizedBox(height: 16),
            const Text(
              'Plataforma',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            customTextField('Ej: Nintendo Switch, PC, PlayStation 5'),

            const SizedBox(height: 16),
            const Text(
              'Fecha de Lanzamiento',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            customTextField('Selecciona la fecha'),

            const SizedBox(height: 16),
            const Text(
              'Estado',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.grey[900],
                initialValue: 'Por jugar',
                items: const [
                  DropdownMenuItem(value: 'Por jugar', child: Text('Por jugar')),
                  DropdownMenuItem(value: 'Jugando', child: Text('Jugando')),
                  DropdownMenuItem(value: 'Completado', child: Text('Completado')),
                ],
                onChanged: (value) {},
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Clasificación',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: List.generate(
                5,
                (index) => const Icon(Icons.star, color: Colors.amber, size: 30),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Portada del Juego',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {},
              child: DottedBorderBox(),
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                GoRouter.of(context).go('/home');
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

  Widget customTextField(String hint) {
    return TextField(
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
}

class DottedBorderBox extends StatelessWidget {
  const DottedBorderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 28),
            SizedBox(height: 6),
            Text('Subir Portada', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
