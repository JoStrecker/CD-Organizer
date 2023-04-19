import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:hive/hive.dart';

class HiveAlbumFacade implements IAlbumFacade {
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
    await albumBox.add(album);
  }

  @override
  Future<void> deleteAlbum(Album album) async {
    var albumBox = await Hive.openBox<Album>('albumBox');
    return await albumBox.deleteAll(
        albumBox.keys.where((element) => albumBox.get(element)?.id == album.id));
  }

  @override
  Future<void> lendAlbum(Album album, String name) async {
    var albumBox = await Hive.openBox<Album>('albumBox');
    return await albumBox.put(
        albumBox.keys.firstWhere((element) => albumBox.get(element)?.id == album.id),
        album.copyWith(
          lended: DateTime.now(),
          lendee: name,
        ));
  }

  @override
  Future<Album?> getAlbum(String id) async {
    var albumBox = await Hive.openBox<Album>('albumBox');
    return albumBox.get(
        albumBox.keys.firstWhere((element) => albumBox.get(element)?.id == id));
  }

  @override
  Future<void> gotBackAlbum(Album album) async {
    var albumBox = await Hive.openBox<Album>('albumBox');
    return await albumBox.put(
      albumBox.keys.firstWhere((element) => albumBox.get(element)?.id == album.id),
      album.copyWith(
        lendee: 'thisAlbumIsNotLent',
      ),
    );
  }

  @override
  Future<void> updateAlbum(Album album, Album updatedAlbum) async {
    var albumBox = await Hive.openBox<Album>('albumBox');
    return await albumBox.put(
      albumBox.keys.firstWhere((element) => albumBox.get(element)?.id == album.id),
      updatedAlbum,
    );
  }
}
