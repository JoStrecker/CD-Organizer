import 'package:music_collection/core/ui/container_text_element.dart';
import 'package:music_collection/feature/music_api/domain/release.dart';
import 'package:music_collection/feature/results/application/result_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultItem extends StatelessWidget {
  final Release release;
  final int index;
  final bool wishlist;

  const ResultItem({
    super.key,
    required this.release,
    required this.index,
    required this.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  top: 8,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 96,
                      minHeight: 96,
                      maxWidth: (MediaQuery.of(context).size.width/4 > 152) ? 152 : MediaQuery.of(context).size.width/4,
                      maxHeight: (MediaQuery.of(context).size.width/4 > 152) ? 152 : MediaQuery.of(context).size.width/4,
                    ),
                    child: release.getThumbnail(
                        tint: Theme.of(context).colorScheme.onTertiaryContainer),
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
                      text: release.title,
                      icon: Icons.people,
                      textColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    ContainerTextElement(
                      text: release.label ?? 'unknown'.tr(),
                      icon: Icons.label,
                      textColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    ContainerTextElement(
                      text: release.year ?? 'unknown'.tr(),
                      icon: Icons.access_time,
                      textColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    ContainerTextElement(
                      text: release.country ?? 'unknown'.tr(),
                      icon: Icons.language,
                      textColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    ContainerTextElement(
                      text: release.formats
                          .reduce((value, element) => '$value, $element'),
                      icon: Icons.album,
                      textColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              tooltip: 'add'.tr(),
              onPressed: () => {
                BlocProvider.of<ResultBloc>(context)
                    .add(ResultSelectAlbumEvent(release, wishlist))
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            )
          ],
        ),
      ),
    );
  }
}
