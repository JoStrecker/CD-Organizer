import 'package:cd_organizer/feature/albums/domain/album.dart';

abstract class IAlbumFacade{
  Future<List<Album>> getAllAlbums(bool? wishlist);
  Future<Album?> getAlbum(String id);
  Future<void> addAlbum(Album album);
  Future<void> deleteAlbum(Album album);
  Future<void> lendAlbum(Album album, String name);
  Future<void> gotBackAlbum(Album album);
  Future<void> updateAlbum(Album album, Album updatedAlbum);
}