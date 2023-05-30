import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class UnauthorizedError extends MusicCollectionError {
  UnauthorizedError({
    super.message = 'unauthorized_error',
    super.description,
  });
}
