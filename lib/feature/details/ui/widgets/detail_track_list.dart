import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailTrackList extends StatelessWidget {
  final Album album;

  const DetailTrackList({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => Row(
        children: [
          Text(album.tracks![index].number),
          const VerticalDivider(),
          Expanded(
            child: Text(
              album.tracks![index].title,
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
          ),
          Text(album.tracks![index].length ?? 'unknown'.tr()),
        ],
      ),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: album.tracks?.length ?? 0,
    );
  }
}
