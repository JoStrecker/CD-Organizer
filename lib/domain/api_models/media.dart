import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final int? disccount;
  final String format;
  final int trackcount;

  const Media({
    this.disccount,
    required this.format,
    required this.trackcount,
  });

  static Media fromJson(Map<String, dynamic> json) {
    return Media(
        disccount: json['disc-count'],
        format: json['format'],
        trackcount: json['track-count']);
  }

  @override
  List<Object?> get props => [
        disccount,
        format,
        trackcount,
      ];
}
