import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextTheme text() {
    return TextTheme(
      titleLarge: GoogleFonts.inter(fontSize: 22),
      bodyMedium: GoogleFonts.poppins(),
      bodySmall: GoogleFonts.inter(),
    );
  }
}
