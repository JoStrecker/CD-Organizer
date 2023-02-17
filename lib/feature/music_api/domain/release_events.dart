import 'package:cd_organizer/feature/music_api/domain/area.dart';
import 'package:equatable/equatable.dart';

class ReleaseEvents extends Equatable {
  final Area? area;
  final String date;

  const ReleaseEvents({
    this.area,
    required this.date,
  });

  static ReleaseEvents fromJson(Map<String, dynamic> json) {
    return ReleaseEvents(
      area: json['area'] != null ? Area.fromJson(json['area']) : null,
      date: json['date'],
    );
  }

  @override
  List<Object?> get props => [
        area,
        date,
      ];
}
