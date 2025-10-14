import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/domain/review.dart';
import 'package:heroicons/heroicons.dart';

class ReviewCard extends ConsumerWidget {
  final Review review;
  final int index;
  final int gameId;
  final String reviewerUsername; // Placeholder username

  const ReviewCard({
    super.key,
    required this.review,
    required this.index,
    required this.gameId,
    required this.reviewerUsername,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color(0xFF1e2128),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 10),
                Text(
                  reviewerUsername,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Row(
                  children: [
                    const HeroIcon(HeroIcons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              review.content,
              style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.3),
            ),
            const SizedBox(height: 12),

            Text(
              '10 de Enero de 2024',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
