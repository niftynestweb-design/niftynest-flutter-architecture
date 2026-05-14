import 'package:flutter/material.dart';

class AppDesign {
  // Spacing Scale
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double space2XL = 48.0;
  static const double space3XL = 64.0;

  // Radius Scale
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusFull = 999.0;

  // Typography - Line Heights & Letter Spacing
  static const double bodyLineHeight = 1.5;
  static const double headingLineHeight = 1.2;
  static const double letterSpacingTight = -0.02;
  static const double letterSpacingNormal = 0.0;

  // Opacity Tokens
  static const double opacityHover = 0.08;
  static const double opacityPressed = 0.12;
  static const double opacityBorder = 0.1;
  static const double opacityTextSecondary = 0.6;

  // Animation Timing
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Curve curveDefault = Curves.easeInOutCubic;

  // Layout Constraints
  static const double maxContentWidth = 1440.0;
  static const double sidebarWidthExpanded = 260.0;
  static const double sidebarWidthCollapsed = 80.0;
}
