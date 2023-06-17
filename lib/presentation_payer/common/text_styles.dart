import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ASTextStyles {
  static final TextStyle headerPage = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Colors.white,
  );
  static final TextStyle buttonText = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.white,
  );
  static final TextStyle buttonTextThin = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.white,
  );
  static final TextStyle secondaryButtonText = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: ASColors.primary,
  );
  static final TextStyle inputTextStyle = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: ASColors.black,
  );
  static final TextStyle calendarDaysTextStyle = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: ASColors.black,
  );
  static final TextStyle sectionTitle = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: ASColors.primary,
  );
  static final TextStyle listTitle = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: ASColors.black,
  );
  static final TextStyle trailingText = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: ASColors.darkGrey,
  );
  static final TextStyle errorText = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: ASColors.redAccent,
  );
}
