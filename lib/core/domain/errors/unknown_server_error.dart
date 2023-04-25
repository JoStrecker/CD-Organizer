import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class UnknownServerError extends MusicCollectionError {
  UnknownServerError({super.message = 'unknown_server_error', super.description});
}
