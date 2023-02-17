import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class NoPermissionError extends CDOrganizerError {
  NoPermissionError({super.message = 'no_permission_error', super.description});
}
