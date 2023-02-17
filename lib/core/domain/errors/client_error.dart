import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';

class ClientError extends CDOrganizerError {
  ClientError({super.message = 'client_error', super.description});
}
