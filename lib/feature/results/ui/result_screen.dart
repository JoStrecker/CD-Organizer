import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/results/ui/widgets/result_item.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<Release> albums;

  const ResultScreen({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: ResultItem(album: albums[index]),
          );
        },
      ),
    );
  }
}
