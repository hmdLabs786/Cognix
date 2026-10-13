import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Dark Twilight Mesh Palette
  static const Color backgroundDark = Color(0xFF090D16); // Dark Slate
  static const Color backgroundSecondary = Color(0xFF131127); // Indigo Obsidian
  static const Color backgroundTertiary = Color(0xFF0D1527); // Deep Navy

  // Light Pearl Mesh Palette
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color backgroundLightSecondary = Color(0xFFF1F5F9); // Slate 100
  static const Color backgroundLightTertiary = Color(0xFFEDE9FE); // Violet 100

  // Glass Surface Constants
  static const Color glassSurfaceDark = Color(0x14FFFFFF); // ~8% white
  static const Color glassSurfaceLight = Color(0xD9FFFFFF); // ~85% white frost
  static const Color glassBorderDark = Color(0x38FFFFFF); // ~22% white
  static const Color glassBorderLight = Color(0x24000000); // ~14% black

  // Accent Colors
  static const Color electricViolet = Color(0xFF818CF8); // Indigo 400
  static const Color violetAccent = Color(0xFFA855F7); // Purple 500
  static const Color neonEmerald = Color(0xFF34D399); // Emerald 400 (Correct)
  static const Color coralCrimson = Color(0xFFF87171); // Red 400 (Incorrect)
  static const Color amberGold = Color(0xFFFBBF24); // Amber 400

  // Aliases for compatibility
  static const Color primaryColor = electricViolet;
  static const Color successColor = neonEmerald;
  static const Color errorColor = coralCrimson;

  // Static Text Hierarchy (Dark Mode default)
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textMuted = Color(0xFF64748B); // Slate 500

  // Static Text Hierarchy (Light Mode)
  static const Color textPrimaryLight = Color(0xFF0F172A); // Slate 900
  static const Color textSecondaryLight = Color(0xFF475569); // Slate 600

  // Background Gradients
  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF090D16),
      Color(0xFF131127),
      Color(0xFF0D1527),
    ],
    stops: [0.0, 0.55, 1.0],
  );

  static const LinearGradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF8FAFC),
      Color(0xFFF1F5F9),
      Color(0xFFEDE9FE),
    ],
    stops: [0.0, 0.55, 1.0],
  );

  // Backward-compatible background gradient getter
  static const LinearGradient backgroundGradient = darkBackgroundGradient;

  static const LinearGradient electricGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF818CF8),
      Color(0xFF6366F1),
      Color(0xFFA855F7),
    ],
  );

  // Contextual Helpers for Dynamic Theming
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static LinearGradient getBackgroundGradient(BuildContext context) =>
      isDark(context) ? darkBackgroundGradient : lightBackgroundGradient;

  static Color getGlassSurface(BuildContext context) =>
      isDark(context) ? glassSurfaceDark : glassSurfaceLight;

  static Color getGlassBorder(BuildContext context) =>
      isDark(context) ? glassBorderDark : glassBorderLight;

  static Color getTextPrimary(BuildContext context) =>
      isDark(context) ? Colors.white : textPrimaryLight;

  static Color getTextSecondary(BuildContext context) =>
      isDark(context) ? textSecondary : textSecondaryLight;

  static Color getCardBackground(BuildContext context) =>
      isDark(context) ? const Color(0x1AFFFFFF) : Colors.white.withValues(alpha: 0.9);

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: electricViolet,
        secondary: violetAccent,
        surface: backgroundSecondary,
        error: coralCrimson,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -0.7,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.2,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.3,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: electricViolet,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: electricViolet,
        secondary: violetAccent,
        surface: Colors.white,
        error: coralCrimson,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimaryLight,
          letterSpacing: -0.7,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: textPrimaryLight,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimaryLight,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimaryLight,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimaryLight,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondaryLight,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimaryLight,
          letterSpacing: 0.2,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimaryLight),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimaryLight,
          letterSpacing: -0.3,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: electricViolet,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
