import 'package:flutter/material.dart';
import '../styles/home_style.dart';

class ProjectCardStyle {
  static const cardPadding = EdgeInsets.all(16);
  static const cardMargin = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: HomeStyle.sectionBackground.withOpacity(0.7),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: HomeStyle.accentColor.withOpacity(0.3),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: HomeStyle.accentColor.withOpacity(0.1),
        blurRadius: 20,
        spreadRadius: 2,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static TextStyle get titleStyle => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: HomeStyle.textPrimary,
  );

  static TextStyle get descriptionStyle => TextStyle(
    fontSize: 14,
    color: HomeStyle.textSecondary,
    height: 1.4,
  );

  static TextStyle get techLabelStyle => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: HomeStyle.accentColor,
  );

  static ButtonStyle get buttonStyle => ElevatedButton.styleFrom(
    backgroundColor: HomeStyle.accentColor,
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}