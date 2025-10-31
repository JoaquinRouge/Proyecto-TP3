import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:proyecto_tp3/core/components/dialogs/delete_review_dialog.dart';
import 'package:proyecto_tp3/provider/review_provider.dart';

class EditReviewBottomSheet extends ConsumerStatefulWidget {
  final void Function(double rating, String review)? onSubmit;

  const EditReviewBottomSheet({
    super.key,
    required this.gameId,
    required this.reviewId,
    required this.rating,
    required this.content,
    this.onSubmit,
  });

  final gameId;
  final reviewId;
  final rating;
  final content;

  @override
  ConsumerState<EditReviewBottomSheet> createState() =>
      _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends ConsumerState<EditReviewBottomSheet> {
  late double rating = widget.rating;
  TextEditingController controller = TextEditingController();
  final int maxChars = 200;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    //Obtener la altura del teclado
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    // Definimos el padding base
    const double basePadding = 20.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            basePadding,
            basePadding,
            basePadding,
            basePadding + bottomInset,
          ),

          decoration: const BoxDecoration(
            color: Color(0xFF1E2128),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: HeroIcon(HeroIcons.chevronDown, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Edita tu reseña',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Center(
                  child: Text(
                    'Comparte tu experiencia con el juego.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                _buildStarRating(),
                const SizedBox(height: 16),
                _buildTextField(),
                const SizedBox(height: 20),
                _buildSubmitButton(context),
                const SizedBox(height: 20),
                _deleteReviewButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStarRating() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        children: List.generate(5, (index) {
          final starValue = index + 1.0;
          final isHalf = (rating - index) == 0.5;

          // Determina el ícono a mostrar (estrella completa, media o borde)
          IconData iconData = Icons.star_border;
          if (rating >= starValue) {
            iconData = Icons.star;
          } else if (isHalf) {
            iconData = Icons.star_half;
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                // 1. Si el usuario toca la estrella ya seleccionada:
                //    - Si es una estrella completa, la reduce a media.
                //    - Si es media estrella, la desactiva (se vuelve a index).
                if (rating == starValue) {
                  rating = starValue - 0.5;
                } else if (rating == starValue - 0.5) {
                  rating = index.toDouble(); // Desactiva la estrella
                }
                // 2. Si toca una estrella no seleccionada, la selecciona completa.
                else {
                  rating = starValue;
                }
              });
            },
            onLongPress: () {
              // Un toque largo puede forzar media estrella
              setState(() {
                rating = starValue - 0.5;
              });
            },
            child: Icon(iconData, color: Colors.amber, size: 36),
          );
        }),
      ),
    );
  }

  Widget _buildTextField() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        TextField(
          controller: controller,
          maxLength: maxChars,
          maxLines: 4,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '¡Increíble juego! Me encantaron los gráficos...',
            hintStyle: const TextStyle(color: Colors.white38),
            counterText: '',
            filled: true,
            fillColor: const Color(0xFF2A2E38),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onChanged: (_) => setState(() {}),
        ),
        Positioned(
          bottom: 8,
          right: 12,
          child: Text(
            '${controller.text.length}/$maxChars',
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () async {
          if (rating == widget.rating && controller.text == widget.content) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('No hubo modificación en los campos.'),
              ),
            );
          } else {
            await ref
                .read(reviewsProvider(widget.gameId).notifier)
                .editReview(widget.reviewId, rating, controller.text.trim());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Reseña modificada'),
              ),
            );
          }
          ref.invalidate(userReviewsProvider);
          Navigator.pop(context);
        },
        child: const Text(
          'Modificar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _deleteReviewButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 176, 49, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () async {
          DeleteReviewDialog.show(context, widget.reviewId, widget.gameId);
        },
        child: const Text(
          'Eliminar Reseña', //
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
