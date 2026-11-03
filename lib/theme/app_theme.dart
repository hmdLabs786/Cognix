import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Consistent, Professional Color Palette
  static const Color background = Color(0xFF0F172A); // Slate 900 (Deep, elegant dark)
  static const Color surface = Color(0xFF1E293B); // Slate 800 (Crisp card surface)
  static const Color surfaceElevated = Color(0xFF283548); // Slightly elevated surface
  static const Color border = Color(0xFF334155); // Slate 700 (Subtle, clean border)
  static const Color borderLight = Color(0xFF475569); // Slate 600

  // Brand Accent (Indigo)
  static const Color primary = Color(0xFF6366F1); // Indigo 500
  static const Color primaryDark = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryLight = Color(0xFF818CF8); // Indigo 400

  // Answer Feedback Colors
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successSurface = Color(0xFF064E3B); // Emerald 900 tint
  static const Color successBorder = Color(0xFF059669); // Emerald 600

  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color errorSurface = Color(0xFF450A0A); // Red 950 tint
  static const Color errorBorder = Color(0xFFDC2626); // Red 600

  // Typography Colors
  static const Color textPrimary = Color(0xFFF8FAFC); // Slate 50 (High contrast)
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textMuted = Color(0xFF64748B); // Slate 500

  // Backward compatibility aliases if referenced
  static const Color primaryColor = primary;
  static const Color successColor = success;
  static const Color errorColor = error;
  static const Color electricViolet = primaryLight;
  static const Color neonEmerald = success;
  static const Color coralCrimson = error;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: primaryLight,
        surface: surface,
        error: error,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.6,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.4,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.4,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: surfaceElevated,
          disabledForegroundColor: textMuted,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
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

  // Theme getters for fallback
  static ThemeData get darkTheme => theme;
  static ThemeData get lightTheme => theme;
}
