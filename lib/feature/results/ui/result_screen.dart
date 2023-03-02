import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/results/ui/widgets/result_item.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<Release> releases;

  const ResultScreen({super.key, required this.releases});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: releases.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: ResultItem(
            release: releases[index],
            index: index,
          ),
        );
      },
    );
  }
}
