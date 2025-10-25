import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_fonts.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class AppTheme {
  static get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AppFonts.dmSerifFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    dividerTheme: DividerThemeData(color: AppColors.accentColor),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.accentColor,
      filled: true,
      hintStyle: TextStyles.styleSize14(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
