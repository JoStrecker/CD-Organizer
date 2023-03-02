import 'dart:io';

import 'package:cd_organizer/feature/albums/domain/track.dart';
import 'package:cd_organizer/generated/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
class Album {
  @HiveField(0)
  String mbid;

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

  Album({
    this.coverArt,
    required this.trackCount,
    required this.label,
    required this.date,
    required this.mbid,
    required this.artists,
    required this.title,
    this.tracks,
  });

  String getAllArtists(){
    return artists.fold('', (previousValue, element) => '$previousValue, $element').replaceFirst(',', '');
  }

  Image getCoverArt(){
    if(coverArt == null){
      return Image.asset(Assets.imagesMissingImage);
    }else {
      return Image.file(File(coverArt!));
    }
  }
}
