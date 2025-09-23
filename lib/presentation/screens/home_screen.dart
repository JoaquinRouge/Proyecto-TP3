import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/appBar.dart';
import 'package:proyecto_tp3/core/components/bottomBar.dart';
import 'package:proyecto_tp3/core/components/gameCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido de nuevo,',
              style: TextStyle(color: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Usuario",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 160,
                  child: GameCard(
                    name: "The Witcher 3: Wild Hunt",
                    rating: 3.5,
                    genres: ["RPG", "Adventure"],
                    coverImage:
                        "https://dixgamer.com/wp-content/uploads/2024/07/the-witcher-3-wild-hunt-245x300.jpg",
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: GameCard(
                    name: "The Witcher 3: Wild Hunt",
                    rating: 3.5,
                    genres: ["RPG", "Adventure"],
                    coverImage:
                        "https://dixgamer.com/wp-content/uploads/2024/07/the-witcher-3-wild-hunt-245x300.jpg",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
