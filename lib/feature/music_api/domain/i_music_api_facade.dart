import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';

abstract class IMusicAPIFacade{
  Future<List<Release>> searchByQuery({required String query});
  Future<List<Release>> searchByBarcode({required String barcode});
  Future<Album> getAlbumForID({required String id});
  Future<double?> getCurrentPriceForID({required String id});
}