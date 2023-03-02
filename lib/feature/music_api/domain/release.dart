import 'package:cd_organizer/core/application/global_vars.dart';
import 'package:cd_organizer/core/infrastructure/dio_response_handler.dart';
import 'package:cd_organizer/feature/music_api/domain/artist_credit.dart';
import 'package:cd_organizer/feature/music_api/domain/label_info.dart';
import 'package:cd_organizer/feature/music_api/domain/media.dart';
import 'package:cd_organizer/feature/music_api/domain/release_events.dart';
import 'package:cd_organizer/feature/music_api/domain/release_group.dart';
import 'package:cd_organizer/feature/music_api/domain/text_representation.dart';
import 'package:cd_organizer/generated/assets.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Release extends Equatable {
  final List<ArtistCredit> artistCredit;
  final String? barcode;
  final int count;
  final String? country;
  final String? date;
  final String id;
  final List<LabelInfo>? labelInfo;
  final List<Media> media;
  final List<ReleaseEvents>? releaseEvents;
  final ReleaseGroup releaseGroup;
  final int score;
  final String status;
  final String statusId;
  final TextRepresentation? textRepresentation;
  final String title;
  final int trackCount;

  const Release({
    required this.artistCredit,
    this.barcode,
    required this.count,
    this.country,
    this.date,
    required this.id,
    this.labelInfo,
    required this.media,
    this.releaseEvents,
    required this.releaseGroup,
    required this.score,
    required this.status,
    required this.statusId,
    this.textRepresentation,
    required this.title,
    required this.trackCount,
  });

  static Release fromJson(Map<String, dynamic> json) {
    return Release(
      artistCredit: json['artist-credit']
          .map<ArtistCredit>((e) => ArtistCredit.fromJson(e))
          .toList(),
      barcode: json['barcode'],
      count: json['count'],
      country: json['country'],
      date: json['date'],
      id: json['id'],
      labelInfo: json['label-info']
          ?.map<LabelInfo>((e) => LabelInfo.fromJson(e))
          .toList(),
      media: json['media'].map<Media>((e) => Media.fromJson(e)).toList(),
      releaseEvents: json['release-events']
          ?.map<ReleaseEvents>((e) => ReleaseEvents.fromJson(e))
          .toList(),
      releaseGroup: ReleaseGroup.fromJson(json['release-group']),
      score: json['score'],
      status: json['status'],
      statusId: json['status-id'],
      textRepresentation: json['text-representation'] != null
          ? TextRepresentation.fromJson(json['text-representation'])
          : null,
      title: json['title'],
      trackCount: json['track-count'],
    );
  }

  @override
  List<Object?> get props => [
        artistCredit,
        barcode,
        count,
        country,
        date,
        id,
        labelInfo,
        media,
        releaseEvents,
        releaseGroup,
        score,
        status,
        statusId,
        textRepresentation,
        title,
        trackCount,
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
    return artistCredit
        .fold('', (previousValue, element) => '$previousValue, ${element.name}')
        .replaceFirst(',', '');
  }
}
