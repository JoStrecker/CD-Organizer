import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

ThemeData getLightTheme(CorePalette? palette, Color? prefColor) {
  return ThemeData.from(
    useMaterial3: true,
    colorScheme: palette?.toColorScheme(brightness: Brightness.light) ??
        ColorScheme.fromSeed(
          seedColor: prefColor ?? const Color(0xff009688),
          brightness: Brightness.light,
        ),
    textTheme: const TextTheme().apply(fontFamily: 'Sora'),
  );
}
