import 'package:hive/hive.dart';

part 'track.g.dart';

@HiveType(typeId: 1)
class Track {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? length;

  @HiveField(2)
  final String number;

  const Track({
    required this.title,
    this.length,
    required this.number,
  });

  static Track fromJson(Map<String, dynamic> json) {
    return Track(
      title: json['title'],
      number: json['position'],
      length: json['duration'],
    );
  }
}
