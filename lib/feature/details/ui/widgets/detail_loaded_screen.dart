import 'package:music_collection/core/ui/back_bar.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_album_details.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_lending_row.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_options_row.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_track_list.dart';
import 'package:flutter/material.dart';

class DetailLoadedScreen extends StatelessWidget {
  final Album album;

  const DetailLoadedScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackBar(ctx: context, text: album.title),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Material(
            elevation: 2,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailAlbumDetails(album: album),
                    album.isLent()
                        ? DetailLendingRow(album: album)
                        : const SizedBox(height: 16),
                    DetailOptionsRow(album: album),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DetailTrackList(album: album),
          ),
        ),
      ],
    );
  }
}
