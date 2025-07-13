import 'package:flutter/material.dart';

class HomeStyle {
  // Padding yang responsive
  static EdgeInsets containerPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: width < 600 ? 24 : 48,
      vertical: width < 600 ? 80 : 120,
    );
  }
  static const TextStyle titleTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  // Warna profesional dark theme
  static Color get sectionBackground => const Color(0xFF0A192F); // Navy Blue
  static Color get accentColor => const Color(0xFF64FFDA); // Teal
  static Color get textPrimary => const Color(0xFFCCD6F6); // Light Blue
  static Color get textSecondary => const Color(0xFF8892B0); // Grey Blue

  // Padding yang adaptif
  static EdgeInsets contentPadding(BuildContext context) {
    return EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24);
  }

  // Text style modern
  static TextStyle get nameTextStyle => const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get descriptionTextStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.6,
      );

  // Button style dengan efek hover
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );

  static ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
        foregroundColor: accentColor,
        side: BorderSide(color: accentColor),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );

  // Ukuran gambar profil
  static double profileImageSize(BuildContext context) {
    return MediaQuery.of(context).size.width < 600 ? 200 : 280;
  }

  // Animasi
  static const Duration hoverDuration = Duration(milliseconds: 300);
  static const Duration entranceDuration = Duration(milliseconds: 800);
}