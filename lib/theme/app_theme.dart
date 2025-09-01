import 'package:flutter/material.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.grayWhite, 
    primaryColor: AppColors.darkBlue,

    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkBlue),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.bluishGray),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.bluishGray),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkBlue),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlue,
        foregroundColor: AppColors.pureWhite,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.darkBlue,
      secondary: AppColors.pinkBeige,
    ),
  );
}
