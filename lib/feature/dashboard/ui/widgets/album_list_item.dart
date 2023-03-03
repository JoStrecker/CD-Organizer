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
        onTap: () => {
          context.goNamed("details", extra: album)
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                width: 80,
                height: 80,
                child: album.getCoverArt(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.album,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        Text(
                          album.title,
                          style: Theme.of(context).textTheme.labelLarge?.apply(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        Text(
                          album.getAllArtists(),
                          style: Theme.of(context).textTheme.labelLarge?.apply(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.format_list_numbered,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        Text(
                          album.trackCount.toString(),
                          style: Theme.of(context).textTheme.labelLarge?.apply(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                        ),
                      ],
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
