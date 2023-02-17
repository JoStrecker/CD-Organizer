import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final int? discCount;
  final String format;
  final int trackCount;

  const Media({
    this.discCount,
    required this.format,
    required this.trackCount,
  });

  static Media fromJson(Map<String, dynamic> json) {
    return Media(
        discCount: json['disc-count'],
        format: json['format'],
        trackCount: json['track-count']);
  }

  @override
  List<Object?> get props => [
        discCount,
        format,
        trackCount,
      ];
}
