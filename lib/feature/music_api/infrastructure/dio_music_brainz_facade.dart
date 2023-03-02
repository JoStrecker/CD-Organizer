import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/core/application/global_vars.dart';
import 'package:cd_organizer/core/infrastructure/dio_response_handler.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_brainz_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/music_api/domain/release_initial.dart';
import 'package:cd_organizer/feature/albums/domain/track.dart';
import 'package:dio/dio.dart';

class DioMusicBrainzFacade extends IMusicBrainzFacade {
  @override
  Future<List<Release>> searchByAlbumTitle({required String albumTitle}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL?query=release:%22${albumTitle.replaceAll(' ',
            '%20')}%22%20AND%20status:%22official%22%20AND%20format:%22cd%22',
        options: Options(
          headers: {
            'User-Agent': userAgentString,
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial
          .fromJson(dioResponseHandler(response))
          .releases;
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
        '$musicRootURL?query=artist:%22${artistName.replaceAll(' ',
            '%20')}%22%20AND%20status:%22official%22%20AND%20format:%22cd%22',
        options: Options(
          headers: {
            'User-Agent': userAgentString,
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial
          .fromJson(dioResponseHandler(response))
          .releases;
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
        '$musicRootURL?query=barcode:%22${barcode.replaceAll(' ',
            '%20')}%22%20AND%20status:%22official%22%20AND%20format:%22cd%22',
        options: Options(
          headers: {
            'User-Agent': userAgentString,
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial
          .fromJson(dioResponseHandler(response))
          .releases;
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }

  @override
  Future<List<Track>?> getTracksForMBID({required String mbid}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL$mbid?inc=recordings',
        options: Options(
          headers: {
            'User-Agent': userAgentString,
            'Accept': 'application/json',
          },
        ),
      );

      List<Track>? result;

      Map<String, dynamic> json = dioResponseHandler(response);
      List<dynamic>? media = json['media'];
      if (media == null) {
        return result;
      }
      result = List.empty(growable: true);
      var i = 1;
      for (var element in media) {
        List<dynamic> tracks = element['tracks'];
        for (var track in tracks) {
          result.add(Track(
            title: track['title'], length: track['length'], number: i++,));
        }
      }

      return result;
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }
}
