import 'dart:io';

import 'package:cd_organizer/feature/albums/domain/track.dart';
import 'package:cd_organizer/generated/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
class Album {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<String> artists;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String label;

  @HiveField(5)
  int trackCount;

  @HiveField(6)
  String? coverArt;

  @HiveField(7)
  List<Track>? tracks;

  @HiveField(8)
  String type;

  Album({
    this.coverArt,
    required this.trackCount,
    required this.label,
    required this.date,
    required this.id,
    required this.artists,
    required this.title,
    required this.type,
    this.tracks,
  });

  static Album fromJson(Map<String, dynamic> json) {
    return Album(
      trackCount: (json['tracklist'] as List).length,
      label: (json['labels'] as List).map((e) => e['name']).toList().reduce((value, element) => '$value, $element'),
      date: DateTime(json['year']),
      id: json['id'].toString(),
      artists: (json['artists'] as List).map((e) => e['name'].toString()).toList(),
      title: json['title'],
      tracks: (json['tracklist'] as List).where((track) => track['type_'] == 'track').map((e) => Track.fromJson(e)).toList(),
      type: (json['formats'] as List).map((e) => e['name']).toList()[0],
    );
  }

  String getAllArtists() {
    return artists.reduce((value, element) => '$value, $element');
  }

  Image getCoverArt() {
    if (coverArt == null) {
      return Image.asset(Assets.imagesMissingImage);
    } else {
      return Image.file(File(coverArt!));
    }
  }
}
