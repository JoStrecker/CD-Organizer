import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

ThemeData getDarkTheme(CorePalette? palette) {
  return ThemeData.from(
    useMaterial3: true,
    colorScheme: palette?.toColorScheme(brightness: Brightness.dark) ??
        ColorScheme.fromSeed(
          seedColor: Colors.tealAccent,
          brightness: Brightness.dark,
        ),
  );
}