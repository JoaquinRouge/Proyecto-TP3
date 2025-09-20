import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class CustomBottomBar extends StatelessWidget {
  final String currentRoute;
  const CustomBottomBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(context, HeroIcons.home, 'Home', '/home'),
            navItem(context, HeroIcons.bookOpen, 'Library', '/library'),
            navItem(context, HeroIcons.magnifyingGlass, 'Search', '/search'),
            navItem(context, HeroIcons.user, 'Profile', '/profile'),
          ],
        ),
      ),
    );
  }

  Column navItem(BuildContext context, HeroIcons icon, String label, String route) {
    final bool isSelected = currentRoute == route;
    final Color color = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (!isSelected) {
              GoRouter.of(context).go(route);
            }
          },
          child: HeroIcon(
            icon,
            style: isSelected ? HeroIconStyle.solid : HeroIconStyle.outline,
            size: 30,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}



