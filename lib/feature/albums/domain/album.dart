import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:image_network/image_network.dart';
import 'package:music_collection/feature/albums/domain/track.dart';
import 'package:music_collection/generated/assets.dart';

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
  Uint8List? coverArt;

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

  @HiveField(13)
  double? worth;

  @HiveField(14)
  String? coverArtUri;

  @HiveField(15)
  DateTime lastUpdated;

  @HiveField(16)
  String? location;

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
    this.worth,
    this.coverArtUri,
    required this.lastUpdated,
    this.location,
  });

  static Album fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'].toString(),
      title: json['title'],
      artists:
          (json['artists'] as List).map((e) => e['name'].toString()).toList(),
      year: (json['year'] ?? 0) > 0 ? json['year'].toString() : null,
      label: json['labels'] != null
          ? (json['labels'] as List)
              .map((e) => e['name'])
              .toList()
              .reduce((value, element) => '$value, $element')
          : null,
      tracks: List.of(
        [
          ...json['tracklist']?.expand(
            (track) => Track.fromJson(track),
          )
        ],
      ),
      type: (json['formats'] as List).map((e) => e['name']).toList()[0],
      country: json['country'],
      wishlist: false,
      trackCount: json['tracklist']?.length.toString(),
      worth: json['lowest_price'],
      lastUpdated: DateTime.now(),
    );
  }

  Album copyWith({
    String? id,
    String? title,
    List<String>? artists,
    String? year,
    String? label,
    Uint8List? coverArt,
    List<Track>? tracks,
    String? type,
    String? country,
    String? lendee,
    DateTime? lended,
    bool? wishlist,
    String? trackCount,
    double? worth,
    String? coverArtUri,
    DateTime? lastUpdated,
    String? location,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      artists: artists ?? this.artists,
      year: year ?? this.year,
      label: label ?? this.label,
      coverArt: coverArt ?? this.coverArt,
      tracks: tracks ?? this.tracks,
      type: type ?? this.type,
      country: country ?? this.country,
      lendee: lendee ?? this.lendee,
      lended: lended ?? this.lended,
      wishlist: wishlist ?? this.wishlist,
      trackCount: trackCount ?? this.trackCount,
      worth: worth ?? this.worth,
      coverArtUri: coverArtUri ?? this.coverArtUri,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
    );
  }

  bool isLent() {
    return (lendee ?? 'thisAlbumIsNotLent') != 'thisAlbumIsNotLent';
  }

  String getAllArtists() {
    return artists.reduce((value, element) => '$value, $element');
  }

  Widget getCoverArt(double size, {Color? tint}) {
    if (coverArt == null) {
      if (coverArtUri == null) {
        return SvgPicture.asset(
          Assets.imagesNoImage,
          colorFilter: ColorFilter.mode(tint ?? Colors.black, BlendMode.srcIn),
        );
      } else {
        return ImageNetwork(
          image: coverArtUri ?? '',
          onLoading: const Center(child: CircularProgressIndicator()),
          onError: SvgPicture.asset(
            Assets.imagesNoImage,
            colorFilter:
                ColorFilter.mode(tint ?? Colors.black, BlendMode.srcIn),
          ),
          height: size,
          width: size,
        );
      }
    } else {
      return Image.memory(
        coverArt!,
        errorBuilder: (context, child, x) => SvgPicture.asset(
          Assets.imagesNoImage,
          colorFilter: ColorFilter.mode(tint ?? Colors.black, BlendMode.srcIn),
        ),
      );
    }
  }
}
