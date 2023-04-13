import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Album album;

  const DetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          album.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                width: 160,
                height: 160,
                child: album.getCoverArt(),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.people),
                    Text(album.getAllArtists()),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.album),
                    Text(album.trackCount.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    Text(album.date.year.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.label),
                    Text(album.label),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledButton(
              onPressed: () => {},
              child: Text(
                'lend'.tr(),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 8,
              ),
            ),
            FilledButton(
              onPressed: () => {},
              child: Text(
                'delete'.tr(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => Row(
              children: [
                Expanded(
                  child: Text(
                    album.tracks![index].title,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                ),
                Text(album.tracks![index].getLengthFormatted()),
              ],
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: album.tracks?.length ?? 0,
          ),
        ),
      ],
    );
  }
}
