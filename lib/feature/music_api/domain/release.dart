import 'package:cd_organizer/generated/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Release extends Equatable {
  final String id;
  final String title;
  final List<String> formats;
  final String? year;
  final String? label;
  final Uri? coverArt;
  final Uri? thumbnail;
  final String? country;

  const Release({
    this.coverArt,
    this.thumbnail,
    this.label,
    this.year,
    this.country,
    required this.formats,
    required this.id,
    required this.title,
  });

  static Release fromJson(Map<String, dynamic> json) {
    return Release(
      id: json['id'].toString(),
      title: json['title'],
      label: json['label']?.toList()[0],
      year: json['year'],
      country: json['country'],
      formats: (json['format'] as List).map((e) => e as String).toList(),
      thumbnail: json['thumb'] != null ? Uri.parse(json['thumb']) : null,
      coverArt:
          json['cover_image'] != null ? Uri.parse(json['cover_image']) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        label,
        coverArt,
        formats,
      ];

  Widget getThumbnail({Color? tint}) {
    return Image.network(
      thumbnail.toString(),
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
        return SvgPicture.asset(
          Assets.imagesNoImage,
          colorFilter: ColorFilter.mode(tint ?? Colors.black, BlendMode.srcIn),
        );
      },
      fit: BoxFit.fill,
      cacheHeight: 80,
      cacheWidth: 80,
    );
  }
}
