import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/provider/review_provider.dart';

class ReviewCard extends ConsumerWidget {
  final Review review;
  final int index;
  final int gameId;

  const ReviewCard({
    super.key,
    required this.review,
    required this.index,
    required this.gameId,
  });

  void _showReviewDialog(BuildContext context, WidgetRef ref, String? initialText) {
    final controller = TextEditingController(text: initialText ?? '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(initialText == null ? 'Agregar Reseña' : 'Editar Reseña'),
        content: TextField(controller: controller, maxLines: 3),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                final notifier = ref.read(reviewsProvider(gameId).notifier);
                if (initialText == null) {
                  notifier.addReview(controller.text.trim());
                } else {
                  notifier.editReview(index, controller.text.trim());
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(reviewsProvider(gameId).notifier);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar Eliminación'),
        content: const Text('¿Seguro que quieres eliminar esta reseña?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              notifier.removeReview(index);
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color(0xFF1e2128),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.content, style: const TextStyle(color: Colors.white, fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _showReviewDialog(context, ref, review.content),
                  child: const Text('Editar', style: TextStyle(color: Colors.blue)),
                ),
                TextButton(
                  onPressed: () => _confirmDelete(context, ref),
                  child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
