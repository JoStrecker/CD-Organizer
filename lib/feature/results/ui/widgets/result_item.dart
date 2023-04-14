import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/results/application/result_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultItem extends StatelessWidget {
  final Release release;
  final int index;

  const ResultItem({super.key, required this.release, required this.index});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
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
                child: release.getCoverArt(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
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
                      Expanded(
                        child: Text(
                          release.title,
                          style: Theme.of(context).textTheme.labelLarge?.apply(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                        release.getAllArtists(),
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
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      Text(
                        release.trackCount.toString(),
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
            onPressed: () => {
              BlocProvider.of<ResultBloc>(context)
                  .add(ResultSelectAlbumEvent(release))
            },
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
