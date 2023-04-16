import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/albums/domain/track.dart';

abstract class IMusicAPIFacade{
  Future<List<Release>> searchByArtist({required String artistName});
  Future<List<Release>> searchByAlbumTitle({required String albumTitle});
  Future<List<Release>> searchByBarcode({required String barcode});
  Future<List<Track>?> getTracksForMBID({required String mbid});
}