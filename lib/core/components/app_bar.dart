import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      toolbarHeight: 80,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 0.1),
      ),

      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      // Logo a la derecha
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Image.asset(
            'assets/images/logo_gameshelf.png',
            height: 40, 
          ),
        ),
      ],
    );
  }
}
