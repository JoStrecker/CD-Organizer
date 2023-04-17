import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:cd_organizer/feature/dashboard/ui/widgets/album_list.dart';
import 'package:cd_organizer/feature/empty/ui/empty_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumListScreen extends StatelessWidget {
  final List<Album> albums;
  final String? search;
  final MediaTypeFilter filter;

  const AlbumListScreen(
      {super.key, required this.albums, this.search, required this.filter});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: search);
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
            onSubmitted: (query) => context
                .read<DashboardBloc>()
                .add(DashboardSearchAlbumEvent(query)),
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'search'.tr(),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.clear;
                  context.read<DashboardBloc>().add(const DashboardLoadEvent());
                },
                icon: const Icon(Icons.clear),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          Center(
            child: SegmentedButton(
              segments: List<ButtonSegment>.of([
                ButtonSegment(
                  value: MediaTypeFilter.all,
                  label: const Text('all').tr(),
                  icon: const Icon(Icons.album),
                ),
                ButtonSegment(
                  value: MediaTypeFilter.vinyl,
                  label: const Text('vinyl').tr(),
                  icon: const Icon(Icons.album),
                ),
                ButtonSegment(
                  value: MediaTypeFilter.cd,
                  label: const Text('cd').tr(),
                  icon: const Icon(Icons.album),
                ),
              ]),
              selected: {filter},
              onSelectionChanged: (selected) => context
                  .read<DashboardBloc>()
                  .add(DashboardFilterAlbumEvent(selected.first)),
            ),
          ),
          Expanded(
            child: albums.isEmpty
                ? const EmptyScreen()
                : AlbumList(
                    albums: albums,
                    deleteAlbum: (Album album) => context
                        .read<DashboardBloc>()
                        .add(DashboardDeleteAlbumEvent(album)),
                  ),
          ),
        ],
      ),
    );
  }
}
