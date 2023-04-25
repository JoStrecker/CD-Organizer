import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class TooManyRequestsError extends MusicCollectionError {
  TooManyRequestsError({super.message = 'too_many_requests_error', super.description});
}
