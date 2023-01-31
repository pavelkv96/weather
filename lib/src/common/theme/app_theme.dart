import 'package:flutter/material.dart';

abstract class AppTheme {
  const AppTheme._();

  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      cardTheme: CardTheme(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      cardTheme: CardTheme(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
