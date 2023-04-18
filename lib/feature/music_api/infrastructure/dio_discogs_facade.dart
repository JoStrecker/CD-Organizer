import 'package:cd_organizer/core/application/env.dart';
import 'package:cd_organizer/core/application/global_vars.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/core/infrastructure/dio_response_handler.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_api_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/music_api/domain/release_initial.dart';
import 'package:dio/dio.dart';

class DioDiscogsFacade extends IMusicAPIFacade{
  @override
  Future<List<Release>> searchByQuery({required String query}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL/database/search?query=${query.replaceAll(' ',
            '%20')}&type=release',
        options: Options(
          headers: {
            'Authorization': 'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial
          .fromJson(dioResponseHandler(response))
          .results;
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
        '$musicRootURL/database/search?barcode=$barcode&type=release',
        options: Options(
          headers: {
            'Authorization': 'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial
          .fromJson(dioResponseHandler(response))
          .results;
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }

  @override
  Future<Album> getAlbumForID({required String id}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL/releases/$id?eur',
        options: Options(
          headers: {
            'Authorization': 'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
            'Accept': 'application/json',
          },
        ),
      );

      return Album.fromJson(dioResponseHandler(response));
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }

  @override
  Future<double?> getCurrentPriceForID({required String id}) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL/releases/$id?eur',
        options: Options(
          headers: {
            'Authorization': 'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
            'Accept': 'application/json',
          },
        ),
      );

      return dioResponseHandler(response)['lowest_price'];
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }
}