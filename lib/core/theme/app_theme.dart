import 'package:flutter/material.dart';

final colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.teal,
];

class AppTheme {
  int selectedColor; 
  bool isDarkMode;

  AppTheme({
    required this.selectedColor,
    required this.isDarkMode,
  });

  ThemeData getThemeData() {
    return ThemeData(
      colorSchemeSeed: colors[selectedColor],
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
}