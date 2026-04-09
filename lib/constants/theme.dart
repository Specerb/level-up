import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kBg = Color(0xFF0A0A0F);
const Color kSurface = Color(0xFF13131A);
const Color kAccent = Color(0xFF4A9EFF);
const Color kGold = Color(0xFFFFD700);
const Color kDanger = Color(0xFFFF4A4A);
const Color kSuccess = Color(0xFF4AFF91);

ThemeData get appTheme => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBg,
      colorScheme: const ColorScheme.dark(
        surface: kSurface,
        primary: kAccent,
        error: kDanger,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.rajdhani(color: Colors.white),
        displayMedium: GoogleFonts.rajdhani(color: Colors.white),
        displaySmall: GoogleFonts.rajdhani(color: Colors.white),
        headlineLarge: GoogleFonts.rajdhani(color: Colors.white),
        headlineMedium: GoogleFonts.rajdhani(color: Colors.white),
        headlineSmall: GoogleFonts.rajdhani(color: Colors.white),
        titleLarge: GoogleFonts.rajdhani(color: Colors.white),
        titleMedium: GoogleFonts.rajdhani(color: Colors.white),
        titleSmall: GoogleFonts.rajdhani(color: Colors.white),
        labelLarge: GoogleFonts.spaceMono(color: Colors.white),
        labelMedium: GoogleFonts.spaceMono(color: Colors.white),
        labelSmall: GoogleFonts.spaceMono(color: Colors.white),
        bodyLarge: GoogleFonts.inter(color: Colors.white),
        bodyMedium: GoogleFonts.inter(color: Colors.white),
        bodySmall: GoogleFonts.inter(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kSurface,
        selectedItemColor: kAccent,
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.spaceMono(fontSize: 10, letterSpacing: 1),
        unselectedLabelStyle: GoogleFonts.spaceMono(fontSize: 10, letterSpacing: 1),
      ),
      dividerColor: Colors.grey.shade800,
      cardColor: kSurface,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? kAccent : Colors.grey),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? kAccent.withOpacity(0.3)
                : Colors.grey.shade800),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kAccent, width: 2),
        ),
        labelStyle: GoogleFonts.spaceMono(color: Colors.grey.shade500, fontSize: 12),
        hintStyle: GoogleFonts.spaceMono(color: Colors.grey.shade700, fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kAccent,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.rajdhani(
              fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kAccent,
          side: const BorderSide(color: kAccent),
          textStyle: GoogleFonts.rajdhani(
              fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: kSurface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
