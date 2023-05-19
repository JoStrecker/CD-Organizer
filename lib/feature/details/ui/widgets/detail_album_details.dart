import 'package:music_collection/core/ui/container_text_element.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailAlbumDetails extends StatelessWidget {
  final Album album;

  const DetailAlbumDetails({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: SizedBox(
            width: 160,
            height: 160,
            child: album.getCoverArt(
              160,
              tint: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerTextElement(
                text: album.getAllArtists(),
                icon: Icons.people,
                maxLines: 2,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              ContainerTextElement(
                text: album.label ?? 'unknown'.tr(),
                icon: Icons.label,
                maxLines: 2,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              ContainerTextElement(
                text: album.year ?? 'unknown'.tr(),
                icon: Icons.access_time,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              ContainerTextElement(
                text: album.country ?? 'unknown'.tr(),
                icon: Icons.language,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              Row(
                children: [
                  Expanded(
                    child: ContainerTextElement(
                      text: album.type,
                      icon: Icons.album,
                      textColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Expanded(
                    child: ContainerTextElement(
                      text: album.worth?.toStringAsFixed(2) ?? 'unknown'.tr(),
                      icon: Icons.euro,
                      textColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
