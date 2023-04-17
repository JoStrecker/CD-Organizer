import 'package:cd_organizer/feature/albums/domain/album.dart';

abstract class IAlbumFacade{
  Future<List<Album>> getAllAlbums();
  Future<void> addAlbum(Album album);
  Future<void> deleteAlbum(Album album);
}