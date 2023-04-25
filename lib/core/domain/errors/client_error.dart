import 'package:music_collection/core/domain/errors/music_collection_error.dart';

class ClientError extends MusicCollectionError {
  ClientError({super.message = 'client_error', super.description});
}
