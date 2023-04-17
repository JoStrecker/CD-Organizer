import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:equatable/equatable.dart';

class ReleaseInitial extends Equatable {
  final List<Release> results;

  const ReleaseInitial({
    required this.results,
  });

  static ReleaseInitial fromJson(Map<String, dynamic> json) {
    return ReleaseInitial(
      results: json['results'].map<Release>((e) => Release.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        results,
      ];
}
