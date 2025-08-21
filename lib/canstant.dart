import 'package:flutter/material.dart';

const String baseUrl = 'https://687cdb85918b642243303314.mockapi.io/api/v1';

const Color primaryColor = Color(0xFF00796B);
const Color backgroundColorLight = Color(0xFFF5F5F5);
const Color textDarkColor = Colors.black87;
const Color whiteColor = Colors.white;

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: backgroundColorLight,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: backgroundColorLight,
    foregroundColor: textDarkColor,
    elevation: 0,
    scrolledUnderElevation: 4,
    surfaceTintColor: backgroundColorLight,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: whiteColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    prefixIconColor: primaryColor,
  ),
);
