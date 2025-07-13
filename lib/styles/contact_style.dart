import 'package:flutter/material.dart';

class ContactStyle {
  // Layout constants
  static const sectionPadding = EdgeInsets.symmetric(vertical: 80, horizontal: 24);
  static const double sectionMaxWidth = 1200;
  static const columnSpacing = SizedBox(width: 48);
  static const rowSpacing = SizedBox(height: 32);
  
  // Container styling
  static BoxDecoration containerDecoration(BuildContext context) => BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 16,
        offset: const Offset(0, 8),
      ),
    ],
    border: Border.all(
      color: Theme.of(context).dividerColor.withOpacity(0.1),
      width: 1,
    ),
  );
  
  static const containerPadding = EdgeInsets.all(32);
  
  // Text styles
  static TextStyle sectionTitleStyle(BuildContext context) => TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: Theme.of(context).colorScheme.onBackground,
  );
  
  static TextStyle sectionSubtitleStyle(BuildContext context) => TextStyle(
    fontSize: 18,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
    height: 1.6,
  );
  
  static TextStyle contactTitleStyle(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
  );
  
  static TextStyle contactItemStyle(BuildContext context) => TextStyle(
    fontSize: 16,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
    height: 1.8,
  );
  
  static TextStyle inputLabelStyle(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
  );
  
  // Input decoration
  static InputDecoration inputDecoration(BuildContext context, String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: inputLabelStyle(context),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
  
  // Button styling
  static ButtonStyle buttonStyle(BuildContext context) => ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.disabled)) {
        return Theme.of(context).colorScheme.primary.withOpacity(0.5);
      }
      if (states.contains(MaterialState.pressed)) {
        return Theme.of(context).colorScheme.primary.withOpacity(0.8);
      }
      return Theme.of(context).colorScheme.primary;
    }),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevation: MaterialStateProperty.resolveWith<double>((states) {
      if (states.contains(MaterialState.hovered)) return 4;
      return 2;
    }),
    textStyle: MaterialStateProperty.all(
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
  
  // Animation
  static const animationDuration = Duration(milliseconds: 300);
  static const hoverDuration = Duration(milliseconds: 200);
  
  // Colors
  static Color iconColor(BuildContext context) => Theme.of(context).colorScheme.primary;
  static Color hoverColor(BuildContext context) => Theme.of(context).colorScheme.primaryContainer;
}