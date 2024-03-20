import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

ThemeData getDarkTheme(
  CorePalette? palette,
  Color? prefColor,
) {
  return ThemeData.from(
    useMaterial3: true,
    colorScheme: palette?.toColorScheme(brightness: Brightness.dark) ??
        ColorScheme.fromSeed(
          seedColor: prefColor ?? const Color(0xff009688),
          brightness: Brightness.dark,
        ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Sora'),
      displayMedium: TextStyle(fontFamily: 'Sora'),
      displaySmall: TextStyle(fontFamily: 'Sora'),
      headlineLarge: TextStyle(fontFamily: 'Sora'),
      headlineMedium: TextStyle(fontFamily: 'Sora'),
      headlineSmall: TextStyle(fontFamily: 'Sora'),
      titleLarge: TextStyle(fontFamily: 'Sora'),
      titleMedium: TextStyle(fontFamily: 'Sora'),
      titleSmall: TextStyle(fontFamily: 'Sora'),
      bodyLarge: TextStyle(fontFamily: 'Sora'),
      bodyMedium: TextStyle(fontFamily: 'Sora'),
      bodySmall: TextStyle(fontFamily: 'Sora'),
      labelLarge: TextStyle(fontFamily: 'Sora'),
      labelMedium: TextStyle(fontFamily: 'Sora'),
      labelSmall: TextStyle(fontFamily: 'Sora'),
    ),
  );
}
