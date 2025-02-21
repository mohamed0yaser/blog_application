import 'package:blog_application/core/theme/pallete.dart';
import 'package:flutter/material.dart';
class AppTheme{
  static _border([Color color= Pallete.borderColor])=> OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    inputDecorationTheme:  InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(Pallete.gradient2),
    )
  );
}