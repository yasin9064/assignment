import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const navy = Color(0xFF062341);
  static const lime = Color(0xFF7ED321);
  static const limeDark = Color(0xFF61B10C);
  static const amber = Color(0xFFDE8A2A);
  static const brown = Color(0xFF6A3A1A);
  static const white = Colors.white;
}

ThemeData buildAppTheme() {
  final textTheme = GoogleFonts.ralewayTextTheme().copyWith(
    displayLarge: GoogleFonts.fredoka(
      fontSize: 36,
      color: AppColors.white,
      letterSpacing: 1.4,
    ),
    displayMedium: GoogleFonts.fredoka(
      fontSize: 32,
      color: AppColors.white,
      letterSpacing: 1.2,
    ),
    headlineMedium: GoogleFonts.raleway(
      fontSize: 24,
      color: AppColors.white,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: GoogleFonts.raleway(
      fontSize: 18,
      color: AppColors.white,
      height: 1.4,
    ),
    bodyMedium: GoogleFonts.raleway(
      fontSize: 16,
      color: AppColors.white,
      height: 1.4,
    ),
  );

  return ThemeData(
    scaffoldBackgroundColor: AppColors.navy,
    colorScheme: const ColorScheme.dark(
      background: AppColors.navy,
      primary: AppColors.lime,
      secondary: AppColors.amber,
      surface: AppColors.navy,
      onPrimary: AppColors.white,
    ),
    textTheme: textTheme,
    useMaterial3: true,
  );
}
