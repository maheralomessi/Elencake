import 'package:flutter/material.dart';

class AppTheme {
  static const Color navy = Color(0xFF21275A);
  static const Color pink = Color(0xFFFF4D90);
  static const Color soft = Color(0xFFF5F6FA);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: navy,
      scaffoldBackgroundColor: Colors.white,
    );

    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: navy,
        secondary: pink,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: soft,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    );
  }
}
