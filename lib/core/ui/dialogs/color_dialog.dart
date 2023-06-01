import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future showColorDialog(
  BuildContext context,
  Color color,
  void Function(Color color) selectCallback,
) {
  Color newColor = color;

  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('pick_color').tr(),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: color,
          onColorChanged: (Color pickedColor) => newColor = pickedColor,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('got_it').tr(),
          onPressed: () {
            selectCallback(newColor);
            Navigator.pop(ctx);
          },
        ),
      ],
    ),
  );
}
