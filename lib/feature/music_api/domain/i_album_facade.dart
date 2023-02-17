import 'package:cd_organizer/feature/music_api/domain/release.dart';

abstract class IAlbumFacade{
  Future<List<Release>> searchByArtist({required String artistName});
  Future<List<Release>> searchByAlbumTitle({required String albumTitle});
  Future<List<Release>> searchByBarcode({required String barcode});
}