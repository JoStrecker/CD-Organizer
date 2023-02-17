import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/core/domain/global_vars.dart';
import 'package:cd_organizer/core/infrastructure/dio_response_handler.dart';
import 'package:cd_organizer/feature/music_api/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/music_api/domain/release_initial.dart';
import 'package:dio/dio.dart';

class DioAlbumFacade extends IAlbumFacade {
  @override
  Future<List<Release>> searchByAlbumTitle({required String albumTitle}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL?query=release:%22${albumTitle.replaceAll(' ', '%20')}%22%20AND%20status:%22official%22%20AND%20format:%22cd%22',
        options: Options(
          headers: {
            'User-Agent': userAgentString,
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial.fromJson(dioResponseHandler(response)).releases;
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }

  @override
  Future<List<Release>> searchByArtist({required String artistName}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL?query=artist:%22${artistName.replaceAll(' ', '%20')}%22%20AND%20status:%22official%22%20AND%20format:%22cd%22',
        options: Options(
          headers: {
            'User-Agent': userAgentString,
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial.fromJson(dioResponseHandler(response)).releases;
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }

  @override
  Future<List<Release>> searchByBarcode({required String barcode}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL?query=barcode:%22${barcode.replaceAll(' ', '%20')}%22%20AND%20status:%22official%22%20AND%20format:%22cd%22',
        options: Options(
          headers: {
            'User-Agent': userAgentString,
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial.fromJson(dioResponseHandler(response)).releases;
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }
}
