import 'package:dio/dio.dart';
import 'package:music_collection/core/domain/errors/client_error.dart';
import 'package:music_collection/core/domain/errors/forbidden_error.dart';
import 'package:music_collection/core/domain/errors/not_found_error.dart';
import 'package:music_collection/core/domain/errors/too_many_requests_error.dart';
import 'package:music_collection/core/domain/errors/unauthorized_error.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/core/domain/errors/unreachable_server_error.dart';

dynamic dioResponseHandler(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return response.data;
    case 401:
      throw UnauthorizedError();
    case 403:
      throw ForbiddenError();
    case 404:
      throw NotFoundError();
    case 400:
    case 409:
    case 415:
      throw ClientError();
    case 429:
      throw TooManyRequestsError();
    case 502:
    case 503:
    case 504:
      throw UnreachableServerError();
  }

  throw UnknownServerError();
}
