import 'package:music_collection/core/route_info.dart';
import 'package:music_collection/feature/dashboard/application/dashboard_bloc.dart';
import 'package:music_collection/feature/dashboard/ui/widgets/album_list_screen.dart';
import 'package:music_collection/feature/empty/ui/empty_screen.dart';
import 'package:music_collection/feature/error/ui/error_screen.dart';
import 'package:music_collection/feature/loading/ui/loading_screen.dart';
import 'package:music_collection/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => sl<DashboardBloc>()..add(const DashboardLoadEvent()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoadedState) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () {
                    context
                        .read<DashboardBloc>()
                        .add(const DashboardRefreshEvent(true));
                    return context.read<DashboardBloc>().stream.firstWhere(
                        (element) => element is DashboardLoadingState);
                  },
                  child: AlbumListScreen(
                    albums: state.albums,
                    search: state.search,
                    filter: state.filter,
                    lentFilter: state.lentFilter,
                    wishlist: false,
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    onPressed: () async => context.read<DashboardBloc>().add(
                          DashboardRefreshEvent(
                            await context.pushNamed(
                              RouteInfo.scanner.name,
                              extra: false,
                            ),
                          ),
                        ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          } else if (state is DashboardLoadingState) {
            return const LoadingScreen();
          } else if (state is DashboardEmptyState) {
            return EmptyScreen(
              child: Column(
                children: [
                  const Text(
                    'tryAddingFirst',
                    textAlign: TextAlign.center,
                  ).tr(),
                  const SizedBox(
                    height: 16,
                  ),
                  FilledButton(
                      onPressed: () async => context.read<DashboardBloc>().add(
                            DashboardRefreshEvent(
                              await context.pushNamed(
                                RouteInfo.scanner.name,
                                extra: false,
                              ),
                            ),
                          ),
                      child: const Text(
                        'addFirstAlbum',
                        textAlign: TextAlign.center,
                      ).tr()),
                ],
              ),
            );
          } else if (state is DashboardErrorState) {
            return ErrorScreen(
              message: state.errorMessage,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
