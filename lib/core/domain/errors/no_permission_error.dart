import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class NoPermissionError extends MusicCollectionError {
  NoPermissionError({super.message = 'no_permission_error', super.description});
}
