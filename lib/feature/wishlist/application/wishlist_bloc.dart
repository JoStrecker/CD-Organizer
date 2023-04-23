import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:flutter/foundation.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  IAlbumFacade albumFacade;

  WishlistBloc({required this.albumFacade}) : super(const WishlistInitialState()) {
    on<WishlistLoadEvent>((event, emit) async {
      emit(const WishlistLoadingState());

      try {
        List<Album> albums = await albumFacade.getAllAlbums(true);
        albums.sort((a, b) => a.title.compareTo(b.title));

        if (albums.isEmpty) {
          emit(const WishlistEmptyState());
        } else {
          emit(WishlistLoadedState(
            albums,
            null,
            const {...MediaTypeFilter.values},
            const {...LentFilter.values},
          ));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
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
              emit(WishlistLoadedState(
                filterAlbums(
                    albums, state.search, state.filter, state.lentFilter),
                state.search,
                state.filter,
                state.lentFilter,
              ));
            }
          } else if (state is WishlistEmptyState) {
            if (albums.isEmpty) {
              emit(const WishlistEmptyState());
            } else {
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
              ));
            }
          } else {
            emit(state);
          }
        } catch (e) {
          if (e is CDOrganizerError) {
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
            emit(WishlistLoadedState(
              filterAlbums(
                  albums, state.search, state.filter, state.lentFilter),
              state.search,
              state.filter,
              state.lentFilter,
            ));
          }
        } catch (e) {
          if (e is CDOrganizerError) {
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

          emit(WishlistLoadedState(
            filterAlbums(albums, event.search, state.filter, state.lentFilter),
            event.search,
            state.filter,
            state.lentFilter,
          ));
        } catch (e) {
          if (e is CDOrganizerError) {
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

          emit(WishlistLoadedState(
            filterAlbums(albums, state.search, event.filter, event.lentFilter),
            state.search,
            event.filter,
            event.lentFilter,
          ));
        } catch (e) {
          if (e is CDOrganizerError) {
            emit(WishlistErrorState(e.message));
          }
          emit(WishlistErrorState(UnknownServerError().message));
        }
      }
    });
  }
}
