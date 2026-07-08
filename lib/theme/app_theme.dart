import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFFF97316); // Orange
  static const Color secondary = Color(0xFF22C55E); // Green (Present)
  static const Color warning = Color(0xFFEAB308); // Yellow (Half-Day)
  static const Color error = Color(0xFFEF4444); // Red (Absent)
  static const Color info = Color(0xFF3B82F6); // Blue (OT)
  
  // Dark Theme
  static const Color darkBg = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkSurfaceAlt = Color(0xFF242424);
  static const Color darkBorder = Color(0xFF333333);
  
  // Light Theme
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE5E5E5);
  
  // Neutral
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textTertiary = Color(0xFF808080);
  
  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color infoLight = Color(0xFFDEF5FF);
  
  // Glassmorphism
  static const Color glassLight = Color(0x0DFFFFFF);
  static const Color glassDark = Color(0x0D000000);
}

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    primaryColor: AppColors.primary,
    textTheme: GoogleFonts.manropeTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.info,
      error: AppColors.error,
      surface: AppColors.darkSurface,
      onSurface: AppColors.textPrimary,
      onPrimary: Colors.white,
      onError: Colors.white,
      onSecondary: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface.withOpacity(0.8),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceAlt,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      hintStyle: GoogleFonts.manrope(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkSurfaceAlt,
      selectedColor: AppColors.primary,
      labelStyle: GoogleFonts.manrope(
        color: AppColors.textPrimary,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 1,
    ),
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    primaryColor: AppColors.primary,
    textTheme: GoogleFonts.manropeTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.info,
      error: AppColors.error,
      surface: AppColors.lightSurface,
      onSurface: Color(0xFF1A1A1A),
      onPrimary: Colors.white,
      onError: Colors.white,
      onSecondary: Colors.white,
    ),
  );
}
