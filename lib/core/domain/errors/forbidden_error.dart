import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class ForbiddenError extends CDOrganizerError {
  ForbiddenError({super.message = 'forbidden_error', super.description});
}
