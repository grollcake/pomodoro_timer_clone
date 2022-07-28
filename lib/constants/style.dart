import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final timeText1Style =
    GoogleFonts.poppins(fontSize: 144, fontWeight: FontWeight.w700, height: 0.9, color: Colors.black);
final timeText2Style =
    GoogleFonts.poppins(fontSize: 144, fontWeight: FontWeight.w300, height: 0.9, color: Colors.black);
final settingTitleTextStyle = GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);
final statTextStyle = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);
final menuTextStyle = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);
final descTextStyle =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.75));
final settingsText1 = GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black);

final menuInactiveColor = Color(0xFFE5E7EB);
final primaryColor = Color(0xFFFF6B6B);
final settingsBg1 = Color(0xFFF9FAFB);

final themeData = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
    fillColor: settingsBg1,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
