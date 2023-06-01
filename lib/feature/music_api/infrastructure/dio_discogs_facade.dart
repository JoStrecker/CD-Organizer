import 'package:music_collection/core/application/env.dart';
import 'package:music_collection/core/application/global_vars.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/core/infrastructure/dio_response_handler.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/music_api/domain/i_music_api_facade.dart';
import 'package:music_collection/feature/music_api/domain/release_initial.dart';
import 'package:dio/dio.dart';

class DioDiscogsFacade extends IMusicAPIFacade {
  @override
  Future<ReleaseInitial> searchByQuery({
    required String query,
    int page = 1,
    int perPage = 30,
  }) async {
    if (perPage > 100) {
      perPage = 100;
    }
    try {
      Response response = await Dio().get(
        '$musicRootURL/database/search?query=${query.replaceAll(' ', '%20')}&type=release&per_page=$perPage&page=$page',
        options: Options(
          headers: {
            'Authorization':
                'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial.fromJson(dioResponseHandler(response));
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }

  @override
  Future<ReleaseInitial> searchByBarcode({
    required String barcode,
  }) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL/database/search?barcode=$barcode&type=release&per_page=100',
        options: Options(
          headers: {
            'Authorization':
                'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
            'Accept': 'application/json',
          },
        ),
      );

      return ReleaseInitial.fromJson(dioResponseHandler(response));
    } catch (e) {
      if (e is DioError && e.response != null) {
        dioResponseHandler(e.response!);
      }
      throw UnknownServerError();
    }
  }

  @override
  Future<Album> getAlbumForID({
    required String id,
  }) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL/releases/$id?eur',
        options: Options(
          headers: {
            'Authorization':
                'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
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
  Future<double?> getCurrentPriceForID({
    required String id,
  }) async {
    try {
      Response response = await Dio().get(
        '$musicRootURL/releases/$id?eur',
        options: Options(
          headers: {
            'Authorization':
                'Discogs key=${Env.apiKey}, secret=${Env.apiSecret}',
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
