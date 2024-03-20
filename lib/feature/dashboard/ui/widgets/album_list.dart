import 'package:flutter/material.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/dashboard/ui/widgets/album_list_item.dart';

class AlbumList extends StatelessWidget {
  final List<Album> albums;
  final bool wishlist;
  final ScrollController controller;

  const AlbumList({
    super.key,
    required this.albums,
    required this.wishlist,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: (index + 1 == albums.length) ? 80 : 8,
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
