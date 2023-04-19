import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'detail_dialogs.dart';

class DetailOptionsRow extends StatelessWidget {
  final Album album;

  const DetailOptionsRow({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => deleteDialog(context),
          icon: const Icon(Icons.delete),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        FilledButton.tonal(
          onPressed: () => album.lendee == null
              ? lendDialog(context)
              : gotBackDialog(context),
          child: Text(
            album.lendee == null ? 'lend'.tr() : 'giveBack'.tr(),
          ),
        ),
      ],
    );
  }
}
