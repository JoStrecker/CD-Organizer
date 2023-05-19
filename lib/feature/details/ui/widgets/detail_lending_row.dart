import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailLendingRow extends StatelessWidget {
  final Album album;

  const DetailLendingRow({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        '${'lendedTo'.tr()}${album.lendee} (${'since'.tr()}${album.lended!.toLocal().day}.${album.lended!.toLocal().month}.${album.lended!.toLocal().year})',
        style: Theme.of(context).textTheme.bodyMedium?.apply(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}
