import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class TooManyRequestsError extends CDOrganizerError {
  TooManyRequestsError({super.message = 'too_many_requests_error', super.description});
}
