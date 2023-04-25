import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class UnreachableServerError extends MusicCollectionError {
  UnreachableServerError({super.message = 'server_not_reach', super.description});
}
