import 'package:flutter/material.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();
  AppTheme._internal();
  factory AppTheme() => _instance;

  ThemeData createTheme({
    Brightness brightness = Brightness.light,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
    );
  }
}
