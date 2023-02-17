import 'package:cd_organizer/domain/api_models/artist_credit.dart';
import 'package:cd_organizer/domain/api_models/label_info.dart';
import 'package:cd_organizer/domain/api_models/media.dart';
import 'package:cd_organizer/domain/api_models/release_events.dart';
import 'package:cd_organizer/domain/api_models/release_group.dart';
import 'package:cd_organizer/domain/api_models/text_representation.dart';
import 'package:equatable/equatable.dart';

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
          .map<LabelInfo>((e) => LabelInfo.fromJson(e))
          .toList(),
      media: json['media'].map<Media>((e) => Media.fromJson(e)).toList(),
      releaseEvents: json['release-events']
          .map<ReleaseEvents>((e) => ReleaseEvents.fromJson(e))
          .toList(),
      releaseGroup: json['release-group']
          .map<ReleaseGroup>((e) => ReleaseGroup.fromJson(e)),
      score: json['score'],
      status: json['status'],
      statusId: json['status-id'],
      textRepresentation: json['text-representation']
          .map<TextRepresentation>((e) => TextRepresentation.fromJson(e)),
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
}
