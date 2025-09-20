import 'package:flutter/material.dart';
import 'package:proyecto_tp3/core/components/appBar.dart';
import 'package:proyecto_tp3/core/components/bottomBar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Search Games"),
      body: Center(
        child: Text('Bienvenido a la pantalla de búsqueda'),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}