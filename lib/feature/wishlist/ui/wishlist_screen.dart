import 'package:music_collection/core/route_info.dart';
import 'package:music_collection/feature/dashboard/ui/widgets/album_list_screen.dart';
import 'package:music_collection/feature/empty/ui/empty_screen.dart';
import 'package:music_collection/feature/error/ui/error_screen.dart';
import 'package:music_collection/feature/loading/ui/loading_screen.dart';
import 'package:music_collection/feature/wishlist/application/wishlist_bloc.dart';
import 'package:music_collection/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WishlistBloc>(
      create: (context) => sl<WishlistBloc>()..add(const WishlistLoadEvent()),
      child: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoadedState) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () {
                    context
                        .read<WishlistBloc>()
                        .add(const WishlistRefreshEvent(true));
                    return context.read<WishlistBloc>().stream.firstWhere(
                        (element) => element is WishlistLoadingState);
                  },
                  child: AlbumListScreen(
                    albums: state.albums,
                    search: state.search,
                    filter: state.filter,
                    lentFilter: state.lentFilter,
                    wishlist: true,
                    scrollController: ScrollController(),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return SizeTransition(
                        axis: Axis.horizontal,
                        sizeFactor: animation,
                        axisAlignment: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: child,
                        ),
                      );
                    },
                    child: FloatingActionButton.extended(
                      key: ValueKey<bool>(state.isAtTop),
                      isExtended: state.isAtTop,
                      onPressed: () async => context.read<WishlistBloc>().add(
                            WishlistRefreshEvent(
                              await context.pushNamed(
                                RouteInfo.scanner.name,
                                extra: false,
                              ),
                            ),
                          ),
                      tooltip: 'add'.tr(),
                      label: const Text('add').tr(),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is WishlistLoadingState) {
            return const LoadingScreen();
          } else if (state is WishlistEmptyState) {
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
                    onPressed: () async => context.read<WishlistBloc>().add(
                          WishlistRefreshEvent(
                            await context.pushNamed(
                              RouteInfo.wishScanner.name,
                              extra: true,
                            ),
                          ),
                        ),
                    child: const Text(
                      'addFirstAlbum',
                      textAlign: TextAlign.center,
                    ).tr(),
                  ),
                ],
              ),
            );
          } else if (state is WishlistErrorState) {
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
