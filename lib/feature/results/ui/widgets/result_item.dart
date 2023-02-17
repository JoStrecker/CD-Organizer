import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final Release album;

  const ResultItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: album.getCoverArt(),
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
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
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
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
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
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => {},
            minWidth: 16,
            height: 80,
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
