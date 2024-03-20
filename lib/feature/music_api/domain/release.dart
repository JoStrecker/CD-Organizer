import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:image_network/image_network.dart';
import 'package:music_collection/generated/assets.dart';

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

  Future<Uint8List?> getCoverArt() async {
    if (coverArt == null) return null;
    try {
      final Response response = await get(coverArt!);
      return response.bodyBytes;
    } catch (e) {
      return null;
    }
  }

  Widget getThumbnail({Color? tint}) {
    // can't be used due to CORS policy
    // return Image.network(
    //   thumbnail.toString(),
    //   frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
    //   loadingBuilder: (context, child, loadingProgress) => Stack(
    //     children: [
    //       child,
    //       Center(
    //         child: CircularProgressIndicator(
    //           value: (loadingProgress?.expectedTotalBytes ?? 1) /
    //               (loadingProgress?.cumulativeBytesLoaded ?? 1),
    //         ),
    //       )
    //     ],
    //   ),
    //   errorBuilder: (context, child, stackTrace) => SvgPicture.asset(
    //     Assets.imagesNoImage,
    //     colorFilter: ColorFilter.mode(tint ?? Colors.black, BlendMode.srcIn),
    //   ),
    // );
    return ImageNetwork(
      image: thumbnail.toString(),
      onLoading: const CircularProgressIndicator(),
      onError: SvgPicture.asset(
        Assets.imagesNoImage,
        colorFilter: ColorFilter.mode(tint ?? Colors.black, BlendMode.srcIn),
      ),
      fitWeb: BoxFitWeb.scaleDown,
      fitAndroidIos: BoxFit.fill,
      height: 152,
      width: 152,
    );
  }
}
