import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_album_details.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_lending_row.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_options_row.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_track_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailLoadedScreenLandscape extends StatelessWidget {
  final Album album;

  const DetailLoadedScreenLandscape({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            right: 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context.pop(true);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 4),
              ),
              Expanded(
                child: Text(
                  album.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailAlbumDetails(album: album),
                          album.isLent()
                              ? DetailLendingRow(album: album)
                              : const SizedBox(height: 8,),
                          DetailOptionsRow(album: album),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16,),
                Expanded(child: DetailTrackList(album: album)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
