import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/dashboard/ui/widgets/album_list_item.dart';
import 'package:flutter/material.dart';

class AlbumList extends StatelessWidget {
  final List<Album> albums;
  final bool wishlist;

  const AlbumList({
    super.key,
    required this.albums,
    required this.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: AlbumListItem(
            album: albums[index],
            wishlist: wishlist,
          ),
        );
      },
    );
  }
}
