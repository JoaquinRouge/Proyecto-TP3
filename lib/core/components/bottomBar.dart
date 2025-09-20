import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:proyecto_tp3/provider/pageProvider.dart';

class CustomBottomBar extends ConsumerWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(pageProvider, (previous,next) {
      if(next != previous) {
        context.go(next);
      }
    });

    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                ref.read(pageProvider.notifier).state = '/home';
              },
              child: navItem(context, HeroIcons.home, 'Home', '/home',ref),
            ),
            GestureDetector(
              onTap: () {
                ref.read(pageProvider.notifier).state = '/library';
              },
              child: navItem(context, HeroIcons.bookOpen, 'Library', '/library',ref),
            ),
            GestureDetector(
              onTap: () {
                ref.read(pageProvider.notifier).state = '/search';
              },
              child:navItem(context, HeroIcons.magnifyingGlass, 'Search', '/search',ref),
            ),
            GestureDetector(
              onTap: () {
                ref.read(pageProvider.notifier).state = '/profile';
              },
              child: navItem(context, HeroIcons.user, 'Profile', '/profile',ref),
            ),
          ],
        ),
      ),
    );
  }

  Column navItem(
    BuildContext context,
    HeroIcons icon,
    String label,
    String route,
    WidgetRef ref
  ) {

    bool samePage = ref.watch(pageProvider) == route;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          HeroIcon(
            icon,
            style: samePage ?  HeroIconStyle.solid : HeroIconStyle.outline,
            size: 25,
            color: samePage ? Theme.of(context).colorScheme.primary : Colors.grey,
          ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: samePage ? Theme.of(context).colorScheme.primary : Colors.grey, fontSize: 11)),
      ],
    );
  }
}
