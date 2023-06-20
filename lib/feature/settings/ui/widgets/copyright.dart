import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            '©2023 Johannes Strecker',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'IBM Plex Mono',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: InkWell(
            child: const Text(
              'data_provider',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'IBM Plex Mono',
              ),
              textAlign: TextAlign.center,
            ).tr(),
            onTap: () => launchUrlString('https://www.discogs.com/developers'),
          ),
        ),
      ],
    );
  }
}
