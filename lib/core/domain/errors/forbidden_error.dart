import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class ForbiddenError extends MusicCollectionError {
  ForbiddenError({
    super.message = 'forbidden_error',
    super.description,
  });
}
