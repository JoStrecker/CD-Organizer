import 'package:cd_organizer/feature/music_api/domain/artist.dart';
import 'package:equatable/equatable.dart';

class ArtistCredit extends Equatable{
  final Artist artist;
  final String name;

  const ArtistCredit({
    required this.artist,
    required this.name,
  });

  static ArtistCredit fromJson(Map<String, dynamic> json) {
    return ArtistCredit(
      artist: Artist.fromJson(json['artist']),
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
    artist,
    name,
  ];
}