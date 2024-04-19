import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary).copyWith(
        background: AppColor.bgColor,
      ),
      appBarTheme: const AppBarTheme(
        color: AppColor.primary,
        foregroundColor: AppColor.white,
        elevation: 0,
      ),
      textTheme: _buildTextTheme(),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColor.primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          textStyle: _buildTextTheme().bodyMedium?.copyWith(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColor.primary,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      titleLarge: GoogleFonts.inter(fontSize: 22),
      bodyMedium: GoogleFonts.poppins(),
      displaySmall: GoogleFonts.inter(),
    );
  }
}
