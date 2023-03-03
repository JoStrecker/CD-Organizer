import 'package:cd_organizer/feature/albums/domain/album.dart';
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
