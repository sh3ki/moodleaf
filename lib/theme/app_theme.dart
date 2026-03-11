import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // MoodLeaf logo color palette
  static const Color primary   = Color(0xFF5BBF30);  // vibrant leaf green
  static const Color secondary = Color(0xFF3AAEE0);  // sky blue
  static const Color accent    = Color(0xFFF0C800);  // sunny yellow
  static const Color pink      = Color(0xFFE07090);  // playful pink
  static const Color purple    = Color(0xFF9B59B6);  // insights purple

  static const Color surface       = Color(0xFFF6FFF4);
  static const Color cardBg        = Colors.white;
  static const Color textPrimary   = Color(0xFF1A3520);
  static const Color textSecondary = Color(0xFF6B8F71);
  static const Color divider       = Color(0xFFDDF0DE);

  static const Map<int, Color> moodColors = {
    5: Color(0xFF5BBF30),  // Great - green
    4: Color(0xFF3AAEE0),  // Good  - blue
    3: Color(0xFFF0C800),  // Okay  - yellow
    2: Color(0xFFE07090),  // Low   - pink
    1: Color(0xFFE84040),  // Awful - red
  };

  static const Map<int, IconData> moodIcons = {
    5: Icons.sentiment_very_satisfied_rounded,
    4: Icons.sentiment_satisfied_rounded,
    3: Icons.sentiment_neutral_rounded,
    2: Icons.sentiment_dissatisfied_rounded,
    1: Icons.sentiment_very_dissatisfied_rounded,
  };

  static const Map<int, String> moodLabels = {
    5: 'Great', 4: 'Good', 3: 'Okay', 2: 'Low', 1: 'Awful',
  };

  static BoxShadow get cardShadow => BoxShadow(
    color: primary.withOpacity(0.10),
    blurRadius: 14,
    offset: const Offset(0, 4),
  );

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary, surface: surface),
    );
    return base.copyWith(
      scaffoldBackgroundColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}
