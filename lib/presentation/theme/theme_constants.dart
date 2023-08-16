import 'package:flutter/material.dart';

final class ThemeConstants {
  static final defaultTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
    useMaterial3: true,
  );

  static const dark = Color(0xFF0A0908);
  static const light = Color(0xFFEAE0D5);
  static const darkBlue = Color(0xFF22333B);
  static const lightBrown = Color(0xFFC6AC8F);
  static const darkBrown = Color(0xFF5E503F);
}
