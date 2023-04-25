import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class NotFoundError extends MusicCollectionError {
  NotFoundError({super.message = 'not_found_error', super.description});
}
