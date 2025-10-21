import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_tp3/core/components/bottom_bar.dart';
import 'package:proyecto_tp3/provider/games_provider.dart';
import 'package:proyecto_tp3/provider/review_provider.dart';
import 'package:proyecto_tp3/provider/user_provider.dart';
import 'package:proyecto_tp3/widget/edit_review_bottom_sheet.dart';
import 'package:proyecto_tp3/widget/review_card.dart';
import 'package:proyecto_tp3/core/components/app_bar.dart';

class UserReviews extends ConsumerWidget {
  const UserReviews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider).value;
    final reviewsAsync = ref.watch(userReviewsProvider(username!));

    return Scaffold(
      appBar: CustomAppBar(title: "Tus reseñas"),
      body: reviewsAsync.when(
        data: (reviews) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return FutureBuilder<String>(
                  future: ref
                      .read(gamesProvider.notifier)
                      .searchGameNameById(review.gameId),
                  builder: (context, snapshot) {
                    final gameName = snapshot.data ?? 'Cargando...';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gameName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => EditReviewBottomSheet(
                                  gameId: review.gameId,
                                  reviewId: review.id,
                                  rating: review.rating,
                                  content: review.content,
                                ),
                            ),
                          },
                          child: ReviewCard(
                            review: review,
                            index: index,
                            gameId: review.gameId,
                            reviewerUsername: review.reviewerUsername,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Text('Error: $e'),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
