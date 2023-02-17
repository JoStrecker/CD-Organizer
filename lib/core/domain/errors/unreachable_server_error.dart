import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class UnreachableServerError extends CDOrganizerError {
  UnreachableServerError({super.message = 'server_not_reach', super.description});
}
