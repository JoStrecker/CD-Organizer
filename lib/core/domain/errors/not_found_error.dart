import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class NotFoundError extends CDOrganizerError {
  NotFoundError({super.message = 'not_found_error', super.description});
}
