import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/music_api/domain/release_initial.dart';

abstract class IMusicAPIFacade {
  Future<ReleaseInitial> searchByQuery({
    required String query,
    int page = 1,
  });

  Future<ReleaseInitial> searchByBarcode({
    required String barcode,
  });

  Future<Album> getAlbumForID({
    required String id,
  });

  Future<double?> getCurrentPriceForID({
    required String id,
  });
}
