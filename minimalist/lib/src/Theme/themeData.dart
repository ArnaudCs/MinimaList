import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: LightColors.primary,
  scaffoldBackgroundColor: LightColors.background,
  cardColor: LightColors.secondary,
  highlightColor: LightColors.secondaryLight,
  dividerColor: LightColors.secondary,
  appBarTheme: const AppBarTheme(
    backgroundColor: LightColors.background,
    titleTextStyle: TextStyle(
      color: LightColors.primaryTextColor,
      fontSize: 20,
      fontFamily: 'Serif',
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: LightColors.iconColor),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LightColors.secondary,
    foregroundColor: LightColors.primaryTextColor,
  ),
  iconTheme: const IconThemeData(
    color: LightColors.iconColor,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: LightColors.primary,
    contentTextStyle: TextStyle(color: LightColors.onPrimary),
  ), 
  dialogBackgroundColor: LightColors.primary,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: DarkColors.primary,
  scaffoldBackgroundColor: DarkColors.background,
  cardColor: DarkColors.secondary,
  highlightColor: DarkColors.secondaryLight,
  dividerColor: DarkColors.secondary,
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkColors.primary,
    titleTextStyle: TextStyle(
      color: DarkColors.primaryTextColor,
      fontSize: 20,
      fontFamily: 'Serif',
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: DarkColors.iconColor),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DarkColors.secondary,
    foregroundColor: DarkColors.primaryTextColor,
  ),
  iconTheme: const IconThemeData(
    color: DarkColors.iconColor,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: DarkColors.primary,
    contentTextStyle: TextStyle(color: DarkColors.onPrimary),
  ), 
  dialogBackgroundColor: DarkColors.primary,
);
