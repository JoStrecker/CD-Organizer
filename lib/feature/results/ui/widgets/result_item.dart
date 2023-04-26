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
                  width: 96,
                  height: 96,
                  child: release.getThumbnail(
                      tint: Theme.of(context).colorScheme.onSecondaryContainer),
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
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  ContainerTextElement(
                    text: release.label ?? 'unknown'.tr(),
                    icon: Icons.label,
                    textColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  ContainerTextElement(
                    text: release.year ?? 'unknown'.tr(),
                    icon: Icons.access_time,
                    textColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  ContainerTextElement(
                    text: release.country ?? 'unknown'.tr(),
                    icon: Icons.language,
                    textColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  ContainerTextElement(
                    text: release.formats
                        .reduce((value, element) => '$value, $element'),
                    icon: Icons.album,
                    textColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => {
              BlocProvider.of<ResultBloc>(context)
                  .add(ResultSelectAlbumEvent(release, wishlist))
            },
            minWidth: 16,
            height: 128,
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
