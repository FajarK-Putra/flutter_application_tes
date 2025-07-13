import 'package:flutter/material.dart';

class AboutMeStyle {
  // Warna diselaraskan dengan home_style
  static Color get sectionBackground => const Color(0xFF0A192F); // Navy Blue
  static Color get accentColor => const Color(0xFF64FFDA); // Teal
  static Color get textPrimary => const Color(0xFFCCD6F6); // Light Blue
  static Color get textSecondary => const Color(0xFF8892B0); // Grey Blue

  // Padding responsive
  static EdgeInsets containerPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: width < 600 ? 24 : 48,
      vertical: width < 600 ? 80 : 120,
    );
  }

  // Ukuran gambar adaptif
  static double profileImageSize(BuildContext context) {
    return MediaQuery.of(context).size.width < 600 ? 200 : 280;
  }

  // Efek visual yang lebih modern
  static BoxDecoration get profileDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: accentColor.withOpacity(0.2),
        blurRadius: 30,
        spreadRadius: 5,
      ),
    ],
    border: Border.all(
      color: accentColor.withOpacity(0.3),
      width: 2,
    ),
  );

  // Text style yang konsisten
  static TextStyle get titleTextStyle => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.5,
    color: Color(0xFFCCD6F6),
  );

  static TextStyle get bodyTextStyle => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: textSecondary,
  );

  // Animasi yang seragam
  static const Duration hoverDuration = Duration(milliseconds: 300);
  static const Duration entranceDuration = Duration(milliseconds: 800);
}