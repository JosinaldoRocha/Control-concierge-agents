import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextTheme text() {
    return TextTheme(
      titleLarge: GoogleFonts.dmSans(fontSize: 22),
      titleMedium: GoogleFonts.dmSans(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      bodyMedium: GoogleFonts.dmSans(),
      bodySmall: GoogleFonts.dmSans(fontSize: 12),
    );
  }
}
