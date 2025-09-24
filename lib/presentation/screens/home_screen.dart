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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GameCard(
                    name: "The Witcher 3: Wild Hunt",
                    rating: 3.5,
                    genres: ["RPG", "Adventure"],
                    coverImage:
                        "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png",
                  ),

                  GameCard(
                    name: "Red Dead Redemption 2",
                    rating: 4.5,
                    genres: ["RPG", "Adventure", "Open World"],
                    coverImage:
                        "https://static.wikia.nocookie.net/rdr/images/3/35/ReddeadII.jpg/revision/latest/scale-to-width-down/1200?cb=20180627190017&path-prefix=es",
                  ),

                  GameCard(
                    name: "Batman Arkham Asylum",
                    rating: 4,
                    genres: ["RPG", "Adventure", "Open World",],
                    coverImage:
                        "https://scontent.ffdo24-3.fna.fbcdn.net/v/t39.30808-6/509419736_9729496613825922_6022802710388952959_n.jpg?stp=dst-jpg_p526x296_tt6&_nc_cat=111&ccb=1-7&_nc_sid=aa7b47&_nc_ohc=z9A7w9LlUm8Q7kNvwFKlkJU&_nc_oc=Adlr0X2fLdT-vS7kdhdJnCwddQTpzhTgZ-Fwpkd0CjC6sKF_qEFl2QkzzHVG-uNY5A_MpdcuBE2uQTuR2Zb8ukNf&_nc_zt=23&_nc_ht=scontent.ffdo24-3.fna&_nc_gid=s8zz1MXCjOTzX0eJ7o_FQQ&oh=00_AfYomNcnh_qfgyW9CduPPDwb0WnCMGIHASgk_fFjXcjfcA&oe=68D9C822",
                  ),

                  GameCard(
                    name: "The Sims 4",
                    rating: 3,
                    genres: ["RPG", "Adventure", "Open World"],
                    coverImage:
                        "https://cdn1.epicgames.com/offer/2a14cf8a83b149919a2399504e5686a6/SIMS4_EPIC_PORTRAIT-Product-Image_1200x1600_1200x1600-aab8b38d851dbd96bcba41d6507d3a32",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
