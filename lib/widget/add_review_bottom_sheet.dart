import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:proyecto_tp3/provider/review_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewBottomSheet extends ConsumerStatefulWidget {
  final void Function(double rating, String review)? onSubmit;

  const ReviewBottomSheet({super.key,required this.gameId, this.onSubmit});

  final gameId;

  @override
  ConsumerState<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends ConsumerState<ReviewBottomSheet> {
  double rating = 0.0;
  final TextEditingController _controller = TextEditingController();
  final int maxChars = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1E2128),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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
          SizedBox(height: 10),
          const Center(
            child: Text(
              'Escribe tu reseña',
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
        ],
      ),
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
          return GestureDetector(
            onTapDown: (details) {
              final box = context.findRenderObject() as RenderBox;
              final localPos = box.globalToLocal(details.globalPosition);
              setState(() {
                // Detecta si clickeó la mitad izquierda → media estrella
                final halfWidth = box.size.width / 10;
                if (localPos.dx < halfWidth * (index * 2 + 1)) {
                  rating = starValue - 0.5;
                } else {
                  rating = starValue;
                }
              });
            },
            child: Icon(
              isHalf
                  ? Icons.star_half
                  : (rating >= starValue ? Icons.star : Icons.star_border),
              color: Colors.amber,
              size: 36,
            ),
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
          controller: _controller,
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
            '${_controller.text.length}/$maxChars',
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
          final user = FirebaseAuth.instance.currentUser;
          String username = "Usuario";
          if (user != null) {
            final uid = user.uid;
            final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
            final data = doc.data();
            if (data != null && data['username'] != null) {
              username = data['username'];
            }
          }
          await ref.read(reviewsProvider(widget.gameId).notifier).addReview(
            rating,
            _controller.text.trim(),
            username,
          );
          Navigator.pop(context);
        },
        child: const Text(
          'Compartir',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
