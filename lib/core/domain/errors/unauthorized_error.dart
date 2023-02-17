import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class UnauthorizedError extends CDOrganizerError {
  UnauthorizedError({super.message = 'unauthorized_error', super.description});
}
