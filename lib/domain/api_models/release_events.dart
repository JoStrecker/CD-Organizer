import 'package:cd_organizer/domain/api_models/area.dart';
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
      area: json['area'].map<Area>((e) => Area.fromJson(e)),
      date: json['date'],
    );
  }

  @override
  List<Object?> get props => [
        area,
        date,
      ];
}
