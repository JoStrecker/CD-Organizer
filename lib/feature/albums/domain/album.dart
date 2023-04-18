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
  String? year;

  @HiveField(4)
  String? label;

  @HiveField(5)
  String? coverArt;

  @HiveField(6)
  List<Track>? tracks;

  @HiveField(7)
  String type;

  @HiveField(8)
  String? country;

  @HiveField(9)
  String? lendee;

  @HiveField(10)
  DateTime? lended;

  @HiveField(11)
  bool wishlist;

  @HiveField(12)
  String? trackCount;

  Album({
    required this.id,
    required this.title,
    required this.artists,
    this.year,
    this.label,
    this.coverArt,
    this.tracks,
    required this.type,
    this.country,
    this.lendee,
    this.lended,
    required this.wishlist,
    this.trackCount,
  });

  static Album fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'].toString(),
      title: json['title'],
      artists:
          (json['artists'] as List).map((e) => e['name'].toString()).toList(),
      year: json['year']?.toString(),
      label: json['labels'] != null
          ? (json['labels'] as List)
              .map((e) => e['name'])
              .toList()
              .reduce((value, element) => '$value, $element')
          : null,
      tracks: List.of(
          [...json['tracklist']?.expand((track) => Track.fromJson(track))]),
      type: (json['formats'] as List).map((e) => e['name']).toList()[0],
      country: json['country'],
      wishlist: false,
      trackCount: json['tracklist']?.length.toString(),
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
