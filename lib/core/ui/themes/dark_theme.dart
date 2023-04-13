import 'package:flutter/material.dart';

ThemeData getDarkTheme({required Color seed}) {
  return ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.dark),
  );
}
