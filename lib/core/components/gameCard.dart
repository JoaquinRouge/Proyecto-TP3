import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String name;
  final double rating;
  final List<String> genres;
  final String coverImage;

  const GameCard({
    super.key,
    required this.name,
    required this.rating,
    required this.genres,
    required this.coverImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // <-- Add this for left alignment
        children: [
          ListTile(
            leading: Image.network(
              coverImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ), // <-- Pad stars to the left
            child: Row(
              children: List.generate(5, (numStar) {
                if (rating >= numStar + 1) {
                  return const Icon(Icons.star, color: Colors.amber, size: 20);
                } else if (rating > numStar && rating < numStar + 1) {
                  return const Icon(
                    Icons.star_half,
                    color: Colors.amber,
                    size: 20,
                  );
                } else {
                  return const Icon(
                    Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
