import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/provider/review_provider.dart';

class AddReviewButton extends ConsumerWidget {
  final int gameId;
  const AddReviewButton({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        final controller = TextEditingController();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Agregar Reseña'),
            content: TextField(controller: controller, maxLines: 3),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    ref.read(reviewsProvider(gameId).notifier).addReview(controller.text.trim());
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.add),
      tooltip: 'Agregar Reseña',
    );
  }
}
