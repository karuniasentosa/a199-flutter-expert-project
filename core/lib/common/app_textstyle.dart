import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static final TextStyle kHeading5 =
  GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
  static final TextStyle kHeading6 = GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
  static final TextStyle kSubtitle = GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
  static final TextStyle kBodyText = GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);
}