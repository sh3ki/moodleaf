import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF0D9488);
  static const Color secondary = Color(0xFF7C3AED);
  static const Color accent = Color(0xFFF59E0B);
  static const Color surface = Color(0xFFF0FDF9);
  static const Color cardBg = Colors.white;

  static const Map<int, Color> moodColors = {
    5: Color(0xFF10B981), // great - emerald
    4: Color(0xFF6EE7B7), // good - light emerald
    3: Color(0xFFF59E0B), // okay - amber
    2: Color(0xFFF97316), // low - orange
    1: Color(0xFFEF4444), // awful - red
  };

  static const Map<int, String> moodEmojis = {
    5: '😄', 4: '🙂', 3: '😐', 2: '😔', 1: '😢',
  };

  static const Map<int, String> moodLabels = {
    5: 'Great', 4: 'Good', 3: 'Okay', 2: 'Low', 1: 'Awful',
  };

  static LinearGradient get heroGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D9488), Color(0xFF0891B2)],
  );

  static LinearGradient get secondaryGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C3AED), Color(0xFF9D4EDD)],
  );

  static List<BoxShadow> get cardShadow => [
    BoxShadow(color: primary.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4)),
  ];

  static List<BoxShadow> get softShadow => [
    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2)),
  ];

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary, surface: surface),
    );
    return base.copyWith(
      scaffoldBackgroundColor: surface,
      textTheme: base.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: primary.withOpacity(0.15),
        labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
