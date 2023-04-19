import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/details/ui/widgets/detail_album_details.dart';
import 'package:cd_organizer/feature/details/ui/widgets/detail_lending_row.dart';
import 'package:cd_organizer/feature/details/ui/widgets/detail_options_row.dart';
import 'package:cd_organizer/feature/details/ui/widgets/detail_track_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailLoadedScreen extends StatelessWidget {
  final Album album;

  const DetailLoadedScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context.pop(false);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 4),
              ),
              Expanded(
                child: Text(
                  album.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailAlbumDetails(album: album),
                  const SizedBox(
                    height: 8,
                  ),
                  album.lendee != null
                      ? DetailLendingRow(album: album)
                      : Container(),
                  DetailOptionsRow(album: album),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: DetailTrackList(album: album),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
