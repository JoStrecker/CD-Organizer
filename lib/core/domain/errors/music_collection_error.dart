class MusicCollectionError extends Error {
  final String message;
  String? description;

  MusicCollectionError({
    required this.message,
    this.description,
  });
}
