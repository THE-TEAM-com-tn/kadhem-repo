import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyColors {
  static const Color primary = const Color(0xFF4B39EF);
  static const Color secondary = const Color(0xFF39D2C0);
  static const Color tertiary = const Color(0xFFEE8B60);
  static const Color alternate = const Color(0xFFFF5963);
  static const Color primaryText = const Color(0xFF101213);
  static const Color secondaryText = const Color(0xFF57636C);
  static const Color primaryBackground = const Color(0xFFF1F4F8);
  static const Color secondaryBackground = const Color(0xFFFFFFFF);
  static const Color accent1 = const Color(0xFF616161);
  static const Color accent2 = const Color(0xFF757575);
  static const Color accent3 = const Color(0xFFE0E0E0);
  static const Color accent4 = const Color(0xFFEEEEEE);
  static const Color success = const Color(0xFF04A24C);
  static const Color warning = const Color(0xFFFCDC0C);
  static const Color error = const Color(0xFFE21C3D);
  static const Color info = const Color(0xFF1C4494);
  static const Color lineColor = const Color(0xFFE0E3E7);
  static const Color bluegreenish = const Color(0xFF62CDFF);
  static const Color mypurple = const Color(0xFFD4ADFC);
  static const Color mygreenMoney = const Color(0xFFB5F1CC);

  /// Admin Dashboard Colors for GridView :

  static const Color Grid0 = const Color(0xFFECF9FF);
  static const Color Grid1 = const Color(0xFFD1FFF3);
  static const Color Grid2 = const Color(0xFFACB1D6);
  static const Color Grid3 = const Color(0xFFDBDFEA);
  static const Color Grid4 = const Color(0xFFFFEAD2);
  static const Color Grid5 = const Color(0xFFB5F1CC);
  static const Color Grid6 = const Color(0xFFECF2FF);
  static const Color Grid7 = const Color(0xFFE3DFFD);
  static const Color Grid8 = const Color(0xFFE5D1FA);
  static const Color Grid9 = const Color(0xFFFFF4D2);

/*
more colors for gridview :
https://colorhunt.co/palette/8294c4acb1d6dbdfeaffead2
https://colorhunt.co/palette/ecf2ffe3dffde5d1fafff4d2
*/

  // TEXT STYLES : POPPINS

  TextStyle get labelNormal => GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        // fontSize: 12.0,
      );

  TextStyle get labelSmall => GoogleFonts.poppins(
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );

  TextStyle get labelMedium => GoogleFonts.poppins(
        color: secondaryText,
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      );

  TextStyle get labelLarge => GoogleFonts.poppins(
        color: secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );

  TextStyle get labelXLarge => GoogleFonts.poppins(
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      );

/*
I will Add this to other fields
  style: MyColors().labelNormal.copyWith(
  fontSize: 16.0,
  ),
  style: MyColors().labelNormal
*/
}
