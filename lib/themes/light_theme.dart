import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)
  );
}