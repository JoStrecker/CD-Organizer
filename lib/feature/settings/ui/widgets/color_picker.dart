import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/core/ui/dialogs/color_dialog.dart';
import 'package:music_collection/core/ui/snack_bars.dart';
import 'package:music_collection/feature/settings/application/settings_bloc.dart';

class ColorPicker extends StatelessWidget {
  final Color color;

  const ColorPicker({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: const Text('pref_color').tr(),
            ),
            FilledButton(
              onPressed: () => showColorDialog(
                context,
                color,
                (newColor) {
                  context.read<SettingsBloc>().add(
                        SettingsChangeColorEvent(
                          (message) => showSnackBar(
                            message,
                            context,
                          ),
                          newColor,
                        ),
                      );
                },
              ),
              child: const Icon(Icons.color_lens),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
