import 'package:flutter/material.dart';
import 'home_style.dart';

class TopbarStyle {
  static EdgeInsets containerPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width < 600 ? 24 : 48,
      vertical: 16,
    );
  }

  static TextStyle get logoTextStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      );

  static TextStyle menuItemStyle(BuildContext context, bool isActive) {
    return TextStyle(
      fontSize: 15,
      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
      color: isActive ? HomeStyle.accentColor : Colors.white.withOpacity(0.9),
      letterSpacing: 0.5,
    );
  }

  static const Duration hoverDuration = Duration(milliseconds: 300);
  static const Curve hoverCurve = Curves.easeOut;
}