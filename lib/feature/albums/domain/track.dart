import 'package:hive/hive.dart';

part 'track.g.dart';

@HiveType(typeId: 1)
class Track {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final int? length;
  
  @HiveField(2)
  final int number;

  const Track({
    required this.title,
    this.length,
    required this.number,
  });
}
