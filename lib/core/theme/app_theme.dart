import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_design_system.dart';

class AppTheme {
  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color backgroundColor = isDark ? AppColors.background : const Color(0xFFF8F9FA);
    final Color cardColor = isDark ? AppColors.card : Colors.white;
    final Color textColor = isDark ? AppColors.textPrimary : const Color(0xFF1A1D21);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        surface: cardColor,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, letterSpacing: AppDesign.letterSpacingTight),
        headlineMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold, letterSpacing: AppDesign.letterSpacingTight),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
        bodyLarge: TextStyle(color: textColor, fontSize: 16, height: AppDesign.bodyLineHeight),
        bodyMedium: TextStyle(color: textColor.withValues(alpha: AppDesign.opacityTextSecondary), fontSize: 14),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesign.radiusL),
          side: BorderSide(
            color: isDark ? AppColors.border : Colors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.border : Colors.grey.withValues(alpha: 0.1),
        thickness: 1,
      ),
    );
  }
}
