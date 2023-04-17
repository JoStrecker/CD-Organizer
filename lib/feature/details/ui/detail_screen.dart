import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Album album;

  const DetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            album.title,
            style: Theme.of(context).textTheme.headlineLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: album.getCoverArt(),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.people),
                        Expanded(
                          child: Text(
                            album.getAllArtists(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.label),
                        Expanded(
                          child: Text(
                            album.label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.access_time),
                        Expanded(
                          child: Text(
                            album.date.year.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.format_list_numbered),
                        Expanded(
                          child: Text(
                            album.trackCount.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.album),
                        Expanded(
                          child: Text(
                            album.type,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilledButton(
                onPressed: () => {},
                child: Text(
                  'lend'.tr(),
                ),
              ),
              const Expanded(
                child: SizedBox(
                  height: 8,
                ),
              ),
              FilledButton(
                onPressed: () => {},
                child: Text(
                  'delete'.tr(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Row(
                children: [
                  Text(album.tracks![index].number),
                  const VerticalDivider(),
                  Expanded(
                    child: Text(
                      album.tracks![index].title,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                    ),
                  ),
                  Text(album.tracks![index].length ?? 'unknown'.tr()),
                ],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: album.tracks?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
