class CDOrganizerError extends Error {
  final String message;
  String? description;
  CDOrganizerError({required this.message, this.description});
}
