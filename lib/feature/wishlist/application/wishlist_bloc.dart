import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_collection/core/application/debouncer.dart';
import 'package:music_collection/core/domain/errors/music_collection_error.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/albums/domain/i_album_facade.dart';
import 'package:music_collection/feature/dashboard/application/dashboard_bloc.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  IAlbumFacade albumFacade;

  WishlistBloc({required this.albumFacade})
      : super(const WishlistInitialState()) {
    on<WishlistLoadEvent>((event, emit) async {
      emit(const WishlistLoadingState());

      try {
        List<Album> albums = await albumFacade.getAllAlbums(true);
        albums.sort((a, b) => a.title.compareTo(b.title));

        if (albums.isEmpty) {
          emit(const WishlistEmptyState());
        } else {
          ScrollController controller = ScrollController();
          Debouncer debouncer =
              Debouncer(duration: const Duration(milliseconds: 50));
          controller.addListener(() {
            debouncer.run(() {
              add(const WishlistScrollAlbumListEvent());
            });
          });
          emit(WishlistLoadedState(
            albums,
            null,
            const {...MediaTypeFilter.values},
            const {...LentFilter.values},
            controller,
            true,
          ));
        }
      } catch (e) {
        if (e is MusicCollectionError) {
          emit(WishlistErrorState(e.message));
        }
        emit(WishlistErrorState(UnknownServerError().message));
      }
    });

    on<WishlistRefreshEvent>((event, emit) async {
      WishlistState state = this.state;

      emit(const WishlistLoadingState());

      if (event.reload ?? false) {
        try {
          List<Album> albums = await albumFacade.getAllAlbums(true);

          if (state is WishlistLoadedState) {
            if (albums.isEmpty) {
              emit(const WishlistEmptyState());
            } else {
              emit(state.copyWith(
                albums: filterAlbums(
                  albums,
                  state.search,
                  state.filter,
                  state.lentFilter,
                ),
              ));
            }
          } else if (state is WishlistEmptyState) {
            if (albums.isEmpty) {
              emit(const WishlistEmptyState());
            } else {
              ScrollController controller = ScrollController();
              Debouncer debouncer =
                  Debouncer(duration: const Duration(milliseconds: 50));
              controller.addListener(() {
                debouncer.run(() {
                  add(const WishlistScrollAlbumListEvent());
                });
              });
              emit(WishlistLoadedState(
                filterAlbums(
                  albums,
                  null,
                  const {...MediaTypeFilter.values},
                  const {...LentFilter.values},
                ),
                null,
                const {...MediaTypeFilter.values},
                const {...LentFilter.values},
                controller,
                true,
              ));
            }
          } else {
            emit(state);
          }
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(WishlistErrorState(e.message));
          }
          emit(WishlistErrorState(UnknownServerError().message));
        }
      }
    });

    on<WishlistDeleteAlbumEvent>((event, emit) async {
      WishlistState state = this.state;

      if (state is WishlistLoadedState) {
        emit(const WishlistLoadingState());

        try {
          await albumFacade.deleteAlbum(event.selectedAlbum);

          List<Album> albums = await albumFacade.getAllAlbums(true);

          if (albums.isEmpty) {
            emit(const WishlistEmptyState());
          } else {
            emit(state.copyWith(
              albums: filterAlbums(
                albums,
                state.search,
                state.filter,
                state.lentFilter,
              ),
            ));
          }
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(WishlistErrorState(e.message));
          }
          emit(WishlistErrorState(UnknownServerError().message));
        }
      }
    });

    on<WishlistSearchAlbumEvent>((event, emit) async {
      WishlistState state = this.state;

      if (state is WishlistLoadedState) {
        emit(const WishlistLoadingState());

        try {
          List<Album> albums = await albumFacade.getAllAlbums(true);

          emit(state.copyWith(
            albums: filterAlbums(
              albums,
              event.search,
              state.filter,
              state.lentFilter,
            ),
            search: event.search,
          ));
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(WishlistErrorState(e.message));
          }
          emit(WishlistErrorState(UnknownServerError().message));
        }
      }
    });

    on<WishlistFilterAlbumEvent>((event, emit) async {
      WishlistState state = this.state;

      if (state is WishlistLoadedState) {
        emit(const WishlistLoadingState());

        try {
          List<Album> albums = await albumFacade.getAllAlbums(true);

          emit(state.copyWith(
            albums: filterAlbums(
              albums,
              state.search,
              event.filter,
              event.lentFilter,
            ),
            filter: event.filter,
            lentFilter: event.lentFilter,
          ));
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(WishlistErrorState(e.message));
          }
          emit(WishlistErrorState(UnknownServerError().message));
        }
      }
    });

    on<WishlistScrollAlbumListEvent>((event, emit) {
      WishlistState state = this.state;

      if (state is WishlistLoadedState) {
        emit(state.copyWith(isAtTop: state.controller.offset == 0));
      }
    });
  }
}
