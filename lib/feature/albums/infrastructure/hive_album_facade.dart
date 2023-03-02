import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:hive/hive.dart';

class HiveAlbumFacade implements IAlbumFacade{
  @override
  Future<List<Album>> getAllAlbums() async {
    var albumBox = await Hive.openBox<Album>('albumBox');

    List<Album> albums = List.empty(growable: true);

    for (var album in albumBox.values) { 
      albums.add(album);
    }

    return albums;
  }

  @override
  Future<void> addAlbum(Album album) async {
    var albumBox = await Hive.openBox<Album>('albumBox');

    albumBox.add(album);
  }
}