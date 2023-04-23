import 'package:cd_organizer/core/ui/dismiss_keyboard.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:cd_organizer/feature/dashboard/ui/widgets/album_list.dart';
import 'package:cd_organizer/feature/dashboard/ui/widgets/album_list_filter.dart';
import 'package:cd_organizer/feature/empty/ui/empty_screen.dart';
import 'package:cd_organizer/feature/wishlist/application/wishlist_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumListScreen extends StatelessWidget {
  final List<Album> albums;
  final String? search;
  final Set<MediaTypeFilter> filter;
  final Set<LentFilter> lentFilter;
  final bool wishlist;

  const AlbumListScreen({
    super.key,
    required this.albums,
    this.search,
    required this.filter,
    required this.lentFilter,
    required this.wishlist,
  });

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
            onSubmitted: (query) => wishlist
                ? context
                    .read<WishlistBloc>()
                    .add(WishlistSearchAlbumEvent(query))
                : context
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
                  unfocusCurrWidget(context);
                  wishlist
                      ? context
                          .read<WishlistBloc>()
                          .add(const WishlistLoadEvent())
                      : context
                          .read<DashboardBloc>()
                          .add(const DashboardLoadEvent());
                },
                icon: const Icon(Icons.clear),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          SizedBox(
            height: 48,
            child: AlbumListFilter(
              filter: filter,
              lentFilter: lentFilter,
              wishlist: wishlist,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('count').tr(),
              Text(albums.length.toString()),
              const Expanded(
                child: SizedBox(
                  height: 1,
                ),
              ),
              const Text('worth').tr(),
              Text(
                  '${albums.fold(0.0, (previousValue, album) => previousValue + (album.worth ?? 0.0)).toStringAsFixed(2)}€'),
            ],
          ),
          Expanded(
            child: albums.isEmpty
                ? const EmptyScreen()
                : AlbumList(
                    albums: albums,
                    wishlist: wishlist,
                  ),
          ),
        ],
      ),
    );
  }
}
