import 'package:flutter/material.dart';

class FlutterdonThemeData {
  // Shared colors
  Color get primaryColor => Colors.deepPurple;
  Color get toolbarColor => Colors.lightBlue;

  // For now, just use the simple light and dark themes
  ThemeData get lightTheme => ThemeData.light().copyWith(
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
          color: toolbarColor,
        ),
        useMaterial3: true,
      );
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        useMaterial3: true,
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
          color: toolbarColor,
        ),
      );
}
