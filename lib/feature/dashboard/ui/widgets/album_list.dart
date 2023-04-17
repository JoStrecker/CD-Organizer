import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/dashboard/ui/widgets/album_list_item.dart';
import 'package:flutter/material.dart';

class AlbumList extends StatelessWidget {
  final List<Album> albums;
  final Function(Album) deleteAlbum;

  const AlbumList({super.key, required this.albums, required this.deleteAlbum});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: AlbumListItem(album: albums[index], deleteAlbum: deleteAlbum,),
        );
      },
    );
  }
}
