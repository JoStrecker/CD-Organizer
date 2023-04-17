import 'package:cd_organizer/core/application/global_vars.dart';
import 'package:cd_organizer/core/infrastructure/dio_response_handler.dart';
import 'package:cd_organizer/generated/assets.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Release extends Equatable {
  final String id;
  final String title;
  final List<String> artists;
  final String? label;
  final int year;
  final int trackCount;
  final Uri? coverArt;

  const Release({
    this.coverArt,
    this.label,
    required this.year,
    required this.id,
    required this.artists,
    required this.title,
    required this.trackCount,
  });

  static Release fromJson(Map<String, dynamic> json) {
    return Release(
      id: json['id'],
      title: json['title'],
      artists: json['artists'].map<Map<String, dynamic>>((e) => e['name']).toList(),
      label: json['labels']?.map<Map<String, dynamic>>((e) => e['name']).toList()[0],
      year: json['year'],
      trackCount: json['tracklist'],
      coverArt: json['images'] != null ? Uri.parse(json['images'].map<Map<String, dynamic>>((e) => e['resource_url']).toList()[0]) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        artists,
        label,
        year,
        trackCount,
        coverArt,
      ];

  Future<bool> hasImage() async {
    try {
      Response response = await Dio().get(
        '${coverRootURL}release/$id/front',
      );
      dioResponseHandler(response);
      return true;
    } catch (e) {
      return false;
    }
  }

  Image getCoverArt() {
    return Image.network(
      '${coverRootURL}release/$id/front',
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronislyLoaded) {
        return child;
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        return Center(
          child: Stack(
            children: [
              child,
              CircularProgressIndicator(
                value: ((loadingProgress?.cumulativeBytesLoaded ?? 0) /
                    (loadingProgress?.expectedTotalBytes ?? 1)),
              ),
            ],
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(Assets.imagesMissingImage);
      },
      fit: BoxFit.fill,
      cacheHeight: 80,
      cacheWidth: 80,
    );
  }

  String getAllArtists() {
    return artists
        .fold('', (previousValue, element) => '$previousValue, $element')
        .replaceFirst(',', '');
  }
}
