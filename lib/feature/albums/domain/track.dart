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

  static List<Track> fromJson(Map<String, dynamic> json) {
    if (json['type_'] == 'track') {
      return List.of([
        Track(
          title: json['title'],
          number: json['position'],
          length: json['duration'],
        ),
      ]);
    } else if (json['type_'] == 'index') {
      return List.of(
        [
          Track(
            title: json['title'],
            number: json['position'],
            length: json['duration'],
          ),
          ...json['sub_tracks'].expand(
            (subtrack) => Track.fromJson(subtrack),
          ),
        ],
      );
    } else {
      return List.empty();
    }
  }
}
