import 'package:flutter/material.dart';

class SkillsCertificationStyle {
  // Layout constants
  static const sectionPadding = EdgeInsets.symmetric(vertical: 40, horizontal: 24);
  static Color backgroundColor(BuildContext context) => 
      Theme.of(context).colorScheme.background;
  static const sectionHeight = 600.0;
  
  // Skill section constants
  static const skillIconSize = 50.0;
  static const skillNameSpacing = SizedBox(height: 8);
  static const horizontalItemPadding = EdgeInsets.symmetric(horizontal: 12);
  
  // Certificate section constants
  static const certCardWidth = 200.0;
  static const certCardHeight = 180.0;
  static const certThumbnailHeight = 120.0;
  static const certCardMargin = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const certBorderRadius = BorderRadius.all(Radius.circular(12));
  
  static BoxDecoration certCardDecoration(bool isHovered) => BoxDecoration(
    color: Colors.white,
    borderRadius: certBorderRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(isHovered ? 0.2 : 0.1),
        blurRadius: isHovered ? 12 : 6,
        offset: Offset(0, isHovered ? 4 : 2),
      ),
    ],
    border: Border.all(
      color: Colors.black.withOpacity(0.05),
      width: 1,
    ),
  );

  static const certTitlePadding = EdgeInsets.all(12.0);
  static const certTitleMaxLines = 2;

  // Spacing constants
  static const betweenSectionsSpace = SizedBox(height: 32);
  static const itemSpacing = SizedBox(height: 16);

  // Text styles
  static TextStyle titleStyle(BuildContext context) => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: Theme.of(context).colorScheme.onBackground,
  );

  static TextStyle skillNameStyle(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
  );

  static TextStyle certificateTitleStyle(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
  );

  // Icons
  static const scrollArrowIcon = Icons.chevron_right;
  static const backArrowIcon = Icons.chevron_left;
    static const downloadIcon = Icons.download_rounded;
    static const closeIcon = Icons.close_rounded;

    // Animation
    static const scrollDuration = Duration(milliseconds: 400);
    static const scrollCurve = Curves.easeInOut;
    static const hoverDuration = Duration(milliseconds: 200);
    static const entranceDuration = Duration(milliseconds: 500);
  }