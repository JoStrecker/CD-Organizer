import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class UnknownServerError extends CDOrganizerError {
  UnknownServerError({super.message = 'unknown_server_error', super.description});
}
