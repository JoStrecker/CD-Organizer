import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/dashboard/ui/widgets/album_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AlbumListScreen extends StatelessWidget {
  final List<Album> albums;

  const AlbumListScreen({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 8,
        right: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_rounded),
              border: InputBorder.none,
              hintText: 'search'.tr(),
            ),
            onChanged: (text) {},
            onSubmitted: (text) {},
          ),
          //Filter Bar
          Expanded(
            child: AlbumList(albums: albums),
          ),
        ],
      ),
    );
  }
}
