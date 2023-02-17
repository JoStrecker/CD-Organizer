import 'package:cd_organizer/domain/api_models/artist.dart';
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
      artist: json['artist'].map<Artist>((e) => Artist.fromJson(e)),
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
    artist,
    name,
  ];
}