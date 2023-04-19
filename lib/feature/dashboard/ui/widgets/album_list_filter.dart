import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumListFilter extends StatelessWidget {
  final Set<MediaTypeFilter> filter;
  final Set<LentFilter> lentFilter;

  const AlbumListFilter({
    super.key,
    required this.filter,
    required this.lentFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedButton<MediaTypeFilter>(
          multiSelectionEnabled: true,
          emptySelectionAllowed: true,
          segments: List<ButtonSegment<MediaTypeFilter>>.of([
            ...MediaTypeFilter.values.map(
              (e) => ButtonSegment<MediaTypeFilter>(
                value: e,
                label: Text(e.name).tr(),
                icon: const Icon(Icons.album),
              ),
            ),
          ]),
          selected: filter,
          onSelectionChanged: (selected) =>
              context.read<DashboardBloc>().add(DashboardFilterAlbumEvent(
                    selected,
                    lentFilter,
                  )),
        ),
        const SizedBox(height: 8),
        SegmentedButton<LentFilter>(
          multiSelectionEnabled: true,
          segments: List<ButtonSegment<LentFilter>>.of([
            ...LentFilter.values.map(
              (e) => ButtonSegment<LentFilter>(
                value: e,
                label: Text(e.name).tr(),
                icon: const Icon(Icons.handshake),
              ),
            ),
          ]),
          selected: lentFilter,
          onSelectionChanged: (selected) =>
              context.read<DashboardBloc>().add(DashboardFilterAlbumEvent(
                    filter,
                    selected,
                  )),
        ),
      ],
    );
  }
}
