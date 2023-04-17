import 'package:cd_organizer/core/ui/container_text_element.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/results/application/result_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
                child: release.getThumbnail(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerTextElement(text: release.title, icon: Icons.people),
                  ContainerTextElement(
                      text: release.label ?? 'unknown'.tr(), icon: Icons.label),
                  ContainerTextElement(
                      text: release.year ?? 'unknown'.tr(),
                      icon: Icons.access_time),
                  ContainerTextElement(
                      text: release.formats
                          .reduce((value, element) => '$value, $element'),
                      icon: Icons.album),
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
