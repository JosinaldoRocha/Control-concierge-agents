import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppText {
  static TextTheme text() {
    return TextTheme(
      titleLarge: GoogleFonts.inter(fontSize: 22),
      titleMedium: GoogleFonts.inter(
        fontSize: 18,
        color: AppColor.primary,
      ),
      bodyMedium: GoogleFonts.poppins(),
      bodySmall: GoogleFonts.inter(),
    );
  }
}
