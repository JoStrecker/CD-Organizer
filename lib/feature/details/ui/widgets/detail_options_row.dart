import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/core/ui/dialogs/add_to_collection_dialog.dart';
import 'package:music_collection/core/ui/dialogs/delete_dialog.dart';
import 'package:music_collection/core/ui/dialogs/got_back_dialog.dart';
import 'package:music_collection/core/ui/dialogs/lend_dialog.dart';
import 'package:music_collection/core/ui/dialogs/location_dialog.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:music_collection/feature/details/application/detail_bloc.dart';

class DetailOptionsRow extends StatelessWidget {
  final Album album;

  const DetailOptionsRow({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          tooltip: 'delete'.tr(),
          onPressed: () => showDeleteDialog(
            context,
            () => context.read<DetailBloc>().add(const DetailDeleteEvent()),
          ),
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        if (!album.wishlist)
          album.location == null
              ? IconButton(
                  tooltip: 'add_location'.tr(),
                  onPressed: () => showLocationDialog(
                    context,
                    album.location,
                    (location) => context
                        .read<DetailBloc>()
                        .add(DetailChangeLocationEvent(location)),
                  ),
                  icon: const Icon(Icons.add_location_alt),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )
              : IconButton(
                  tooltip: 'change_location'.tr(),
                  onPressed: () => showLocationDialog(
                    context,
                    album.location,
                    (location) => context
                        .read<DetailBloc>()
                        .add(DetailChangeLocationEvent(location)),
                  ),
                  icon: const Icon(Icons.edit_location_alt),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
        const Expanded(
          child: SizedBox(),
        ),
        album.wishlist
            ? FilledButton(
                onPressed: () => showAddToCollectionDialog(context),
                child: const Text('add_to_collection').tr())
            : FilledButton(
                onPressed: () => album.isLent()
                    ? showGotBackDialog(context)
                    : showLendDialog(
                        context,
                        (String text) => context
                            .read<DetailBloc>()
                            .add(DetailLendEvent(text)),
                      ),
                child: Text(
                  album.isLent() ? 'give_back'.tr() : 'lend'.tr(),
                ),
              ),
      ],
    );
  }
}
