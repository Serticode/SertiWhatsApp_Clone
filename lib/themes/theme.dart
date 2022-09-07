import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theAppTheme => ThemeData(
      //! HOW PAGES TRANSITION BETWEEN EACH OTHER
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder()
      }),

      //! APP BRIGHTNESS
      brightness: Brightness.dark,

      //! OTHER COLOURS
      scaffoldBackgroundColor: AppColours.backgroundColor,

      //! APP BAR THEME
      appBarTheme:
          const AppBarTheme(color: AppColours.appBarColor, elevation: 0.0),

      //! TEXT THEMES
      textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: 21.0,
              color: AppColours.textColor),
          headline2: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: AppColours.textColor),
          bodyText1: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: AppColours.textColor,
                  fontSize: 14.0)
              .copyWith(overflow: TextOverflow.ellipsis),
          bodyText2: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: AppColours.textColor,
                  fontSize: 12.0)
              .copyWith(overflow: TextOverflow.ellipsis)),

      //! SNACK BAR
      snackBarTheme: SnackBarThemeData(
          elevation: 12.0,
          backgroundColor: AppColours.snackBarColour,
          contentTextStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: AppColours.textColor,
              fontSize: 14.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(21.0), topRight: Radius.circular(21.0)))),

      //! BOTTOM SHEET THEME
      bottomSheetTheme: const BottomSheetThemeData(elevation: 12.0, backgroundColor: Colors.transparent),

      //! ELEVATED BUTTON
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 21.0), backgroundColor: AppColours.elevatedButtonColour, textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)))),

      //! TEXT FORM FIELD DECORATION
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColours.searchBarColor,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: const Color(0XFFB7B7B7),
            fontSize: 18.0,
          ).copyWith(overflow: TextOverflow.ellipsis),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColours.textColor.withOpacity(0.8), fontSize: 14.0).copyWith(overflow: TextOverflow.ellipsis),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.0)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.0))));
}

class AppColours {
  static const backgroundColor = Color.fromRGBO(19, 28, 33, 1);
  static const textColor = Color.fromRGBO(241, 241, 242, 1);
  static const appBarColor = Color.fromRGBO(31, 44, 52, 1);
  static const webAppBarColor = Color.fromRGBO(42, 47, 50, 1);
  static const messageColor = Color.fromRGBO(5, 96, 98, 1);
  static const senderMessageColor = Color.fromRGBO(37, 45, 49, 1);
  static const tabColor = Color.fromRGBO(0, 167, 131, 1);
  static const searchBarColor = Color.fromRGBO(50, 55, 57, 1);
  static const dividerColor = Color.fromRGBO(37, 45, 50, 1);
  static const chatBarMessage = Color.fromRGBO(12, 36, 40, 1);
  static const mobileChatBoxColor = Color.fromRGBO(31, 44, 52, 1);
  static const elevatedButtonColour = Color.fromRGBO(0, 167, 131, 1);
  static const snackBarColour = Color.fromRGBO(0, 167, 131, 1);
  static const landingScreenImageColour = Color.fromRGBO(0, 167, 131, 1);
}
