import 'package:flutter/material.dart';
import 'package:flutter_application_tes/styles/home_style.dart';

class EducationExperienceStyle {
  // Padding yang responsive
  static EdgeInsets sectionPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return EdgeInsets.symmetric(
      horizontal: width < 600 ? 24 : 48,
      vertical: width < 600 ? 40 : 80,
    );
  }

  // Warna profesional dark theme (match dengan HomeStyle)
  static Color get sectionBackground => HomeStyle.sectionBackground;
  static Color get accentColor => HomeStyle.accentColor;
  static Color get textPrimary => HomeStyle.textPrimary;
  static Color get textSecondary => HomeStyle.textSecondary;

  // Spacing yang konsisten
  static const columnSpacing = SizedBox(width: 32);
  static const rowSpacing = SizedBox(height: 32);
  static const itemSpacing = SizedBox(height: 20);
  static const bulletSpacing = SizedBox(width: 12);
  
  // Container styling yang match dengan tema
  static BoxDecoration containerDecoration(BuildContext context) => BoxDecoration(
    color: const Color(0xFF112240), // Darker navy blue
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: accentColor.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
    border: Border.all(
      color: const Color(0xFF1E2D4A), // Border color
      width: 1,
    ),
  );
  
  static EdgeInsets containerPadding(BuildContext context) {
    return EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24);
  }
  
  // Text styles yang konsisten dengan HomeStyle
  static TextStyle sectionTitleStyle(BuildContext context) => TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: textPrimary,
    letterSpacing: -0.5,
  );
  
  static TextStyle sectionSubtitleStyle(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.6,
  );
  
  static TextStyle subsectionTitleStyle(BuildContext context) => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: textPrimary,
  );
  
  static TextStyle itemTitleStyle(BuildContext context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static TextStyle itemSubtitleStyle(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: accentColor, // Using accent color for subtitles
  );
  
  static TextStyle itemDateStyle(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );
  
  static TextStyle descriptionTextStyle(BuildContext context) => TextStyle(
    fontSize: 15,
    height: 1.6,
    color: textSecondary,
  );
  
  static TextStyle bulletTextStyle(BuildContext context) => TextStyle(
    fontSize: 14,
    height: 1.5,
    color: textPrimary.withOpacity(0.9),
  );
  
  // Animasi yang konsisten
  static const animationDuration = Duration(milliseconds: 300);
  static const hoverDuration = HomeStyle.hoverDuration;
  static const entranceDuration = HomeStyle.entranceDuration;
  
  // Button style yang match
  static ButtonStyle get primaryButtonStyle => HomeStyle.primaryButtonStyle;
  static ButtonStyle get secondaryButtonStyle => HomeStyle.secondaryButtonStyle;
}