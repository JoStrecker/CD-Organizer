import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:equatable/equatable.dart';

class ReleaseInitial extends Equatable {
  final int offset;
  final int count;
  final String created;
  final List<Release> releases;

  const ReleaseInitial({
    required this.offset,
    required this.count,
    required this.created,
    required this.releases,
  });

  static ReleaseInitial fromJson(Map<String, dynamic> json) {
    return ReleaseInitial(
      offset: json['offset'],
      count: json['count'],
      created: json['created'],
      releases:
          json['releases'].map<Release>((e) => Release.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        offset,
        count,
        created,
        releases,
      ];
}
