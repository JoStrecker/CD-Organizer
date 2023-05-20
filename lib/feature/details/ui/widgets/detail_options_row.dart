import 'package:music_collection/feature/albums/domain/album.dart';
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
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        const Expanded(
          child: SizedBox(),
        ),
        album.wishlist
            ? FilledButton(
                onPressed: () => addCollectionDialog(context),
                child: const Text('addToCollection').tr())
            : FilledButton(
                onPressed: () => album.isLent()
                    ? gotBackDialog(context)
                    : lendDialog(context),
                child: Text(
                  album.isLent() ? 'giveBack'.tr() : 'lend'.tr(),
                ),
              ),
      ],
    );
  }
}
