import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:music_collection/core/ui/snack_bars.dart';
import 'package:music_collection/feature/settings/application/settings_bloc.dart';

class ColorPicker extends StatelessWidget {
  final Color color;

  const ColorPicker({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('prefColor').tr(),
        const Expanded(child: SizedBox()),
        FilledButton(
          onPressed: () => colorDialog(context, color),
          child: const Icon(Icons.color_lens),
        ),
      ],
    );
  }
}

Future colorDialog(BuildContext context, Color color) {
  Color newColor = color;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
          String message) =>
      showSnackBar(message, context);

  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('pickColor').tr(),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: color,
          onColorChanged: (Color pickedColor) => newColor = pickedColor,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('gotIt').tr(),
          onPressed: () {
            context.read<SettingsBloc>().add(SettingsChangeColorEvent(
                  snackBar,
                  newColor,
                ));
            Navigator.pop(ctx);
          },
        ),
      ],
    ),
  );
}
