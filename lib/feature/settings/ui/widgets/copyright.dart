import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '©2023 Johannes Strecker',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'IBM Plex Mono',
            ),
            textAlign: TextAlign.center,
          ),
          InkWell(
            child: Text(
              'data_provider'.tr(),
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'IBM Plex Mono',
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () => launchUrlString('https://www.discogs.com/developers'),
          ),
        ],
      ),
    );
  }
}
