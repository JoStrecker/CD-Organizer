import 'package:cd_organizer/core/ui/container_text_element.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlbumListItem extends StatelessWidget {
  final Album album;
  final Function(Album) deleteAlbum;

  const AlbumListItem({
    super.key,
    required this.album,
    required this.deleteAlbum,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () => context.goNamed("details", extra: album),
        onLongPress: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('delete').tr(),
                  content: const Text('wantToDelete').tr(),
                  actions: [
                    FilledButton.tonal(
                      onPressed: () => Navigator.pop(context, 'cancel'),
                      child: const Text('cancel').tr(),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context, 'yes');
                        deleteAlbum(album);
                      },
                      child: const Text('yes').tr(),
                    )
                  ],
                )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 4,
                top: 4,
                bottom: 4,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: album.getCoverArt(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContainerTextElement(
                      text: album.title,
                      icon: Icons.title,
                      textColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    ContainerTextElement(
                      text: album.getAllArtists(),
                      icon: Icons.people,
                      textColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    ContainerTextElement(
                      text: album.year ?? 'unknown'.tr(),
                      icon: Icons.access_time,
                      textColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    ContainerTextElement(
                      text: album.type,
                      icon: Icons.album,
                      textColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
