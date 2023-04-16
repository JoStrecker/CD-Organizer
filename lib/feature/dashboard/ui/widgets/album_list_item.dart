import 'package:cd_organizer/core/ui/container_text_element.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlbumListItem extends StatelessWidget {
  final Album album;

  const AlbumListItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        onTap: () => {context.goNamed("details", extra: album)},
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
                  width: 80,
                  height: 80,
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
                      icon: Icons.album,
                    ),
                    ContainerTextElement(
                      text: album.getAllArtists(),
                      icon: Icons.people,
                    ),
                    ContainerTextElement(
                      text: album.trackCount.toString(),
                      icon: Icons.format_list_numbered,
                    ),
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
