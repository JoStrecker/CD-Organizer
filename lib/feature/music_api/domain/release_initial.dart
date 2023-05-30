import 'package:music_collection/feature/music_api/domain/release.dart';
import 'package:equatable/equatable.dart';

class ReleaseInitial extends Equatable {
  final List<Release> results;
  final int pages;

  const ReleaseInitial({
    required this.results,
    required this.pages,
  });

  static ReleaseInitial fromJson(Map<String, dynamic> json) {
    return ReleaseInitial(
      results:
          json['results'].map<Release>((e) => Release.fromJson(e)).toList(),
      pages: json['pagination']['pages'],
    );
  }

  @override
  List<Object?> get props => [
        results,
        pages,
      ];
}
