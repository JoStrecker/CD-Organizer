import 'package:music_collection/feature/dashboard/application/dashboard_bloc.dart';
import 'package:music_collection/feature/wishlist/application/wishlist_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumListFilter extends StatelessWidget {
  final Set<MediaTypeFilter> filter;
  final Set<LentFilter> lentFilter;
  final bool wishlist;

  const AlbumListFilter({
    super.key,
    required this.filter,
    required this.lentFilter,
    required this.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    List<String> labels = wishlist
        ? [...MediaTypeFilter.values.map((e) => e.name)]
        : [
            ...MediaTypeFilter.values.map((e) => e.name),
            ...LentFilter.values.map((e) => e.name)
          ];
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: labels.length,
      itemBuilder: (ctx, index) => FilterChip(
        label: Text(labels[index]).tr(),
        selected: filter.map((e) => e.name).contains(labels[index]) ||
            lentFilter.map((e) => e.name).contains(labels[index]),
        onSelected: (selected) {
          List<MediaTypeFilter> newFilter = [...filter];
          List<LentFilter> newLentFilter = [...lentFilter];
          if (index < MediaTypeFilter.values.length) {
            if (selected) {
              newFilter.add(MediaTypeFilter.values[index]);
            } else {
              if (newFilter.length == 1) return;
              newFilter.remove(MediaTypeFilter.values[index]);
            }
          } else {
            if (selected) {
              newLentFilter.add(
                LentFilter.values[index - MediaTypeFilter.values.length],
              );
            } else {
              if (newLentFilter.length == 1) return;
              newLentFilter.remove(
                LentFilter.values[index - MediaTypeFilter.values.length],
              );
            }
          }
          wishlist
              ? context.read<WishlistBloc>().add(
                    WishlistFilterAlbumEvent(
                      newFilter.toSet(),
                      newLentFilter.toSet(),
                    ),
                  )
              : context.read<DashboardBloc>().add(
                    DashboardFilterAlbumEvent(
                      newFilter.toSet(),
                      newLentFilter.toSet(),
                    ),
                  );
        },
      ),
      separatorBuilder: (ctx, index) => const SizedBox(
        width: 8,
      ),
    );
  }
}
