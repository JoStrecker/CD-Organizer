import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, BuildContext ctx) {
  return ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}