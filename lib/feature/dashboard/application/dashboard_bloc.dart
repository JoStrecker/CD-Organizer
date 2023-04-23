import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:flutter/foundation.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  IAlbumFacade albumFacade;

  DashboardBloc({required this.albumFacade})
      : super(const DashboardInitialState()) {
    on<DashboardLoadEvent>((event, emit) async {
      emit(const DashboardLoadingState());

      try {
        List<Album> albums = await albumFacade.getAllAlbums(false);
        albums.sort((a, b) => a.title.compareTo(b.title));

        if (albums.isEmpty) {
          emit(const DashboardEmptyState());
        } else {
          emit(DashboardLoadedState(
            albums,
            null,
            const {...MediaTypeFilter.values},
            const {...LentFilter.values},
          ));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
          emit(DashboardErrorState(e.message));
        }
        emit(DashboardErrorState(UnknownServerError().message));
      }
    });

    on<DashboardRefreshEvent>((event, emit) async {
      DashboardState state = this.state;

      emit(const DashboardLoadingState());

      if (event.reload ?? false) {
        try {
          List<Album> albums = await albumFacade.getAllAlbums(false);

          if (state is DashboardLoadedState) {
            if (albums.isEmpty) {
              emit(const DashboardEmptyState());
            } else {
              emit(DashboardLoadedState(
                filterAlbums(
                    albums, state.search, state.filter, state.lentFilter),
                state.search,
                state.filter,
                state.lentFilter,
              ));
            }
          } else if (state is DashboardEmptyState) {
            if (albums.isEmpty) {
              emit(const DashboardEmptyState());
            } else {
              emit(DashboardLoadedState(
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
            emit(DashboardErrorState(e.message));
          }
          emit(DashboardErrorState(UnknownServerError().message));
        }
      }
    });

    on<DashboardDeleteAlbumEvent>((event, emit) async {
      DashboardState state = this.state;

      if (state is DashboardLoadedState) {
        emit(const DashboardLoadingState());

        try {
          await albumFacade.deleteAlbum(event.selectedAlbum);

          List<Album> albums = await albumFacade.getAllAlbums(false);

          if (albums.isEmpty) {
            emit(const DashboardEmptyState());
          } else {
            emit(DashboardLoadedState(
              filterAlbums(
                  albums, state.search, state.filter, state.lentFilter),
              state.search,
              state.filter,
              state.lentFilter,
            ));
          }
        } catch (e) {
          if (e is CDOrganizerError) {
            emit(DashboardErrorState(e.message));
          }
          emit(DashboardErrorState(UnknownServerError().message));
        }
      }
    });

    on<DashboardSearchAlbumEvent>((event, emit) async {
      DashboardState state = this.state;

      if (state is DashboardLoadedState) {
        emit(const DashboardLoadingState());

        try {
          List<Album> albums = await albumFacade.getAllAlbums(false);

          emit(DashboardLoadedState(
            filterAlbums(albums, event.search, state.filter, state.lentFilter),
            event.search,
            state.filter,
            state.lentFilter,
          ));
        } catch (e) {
          if (e is CDOrganizerError) {
            emit(DashboardErrorState(e.message));
          }
          emit(DashboardErrorState(UnknownServerError().message));
        }
      }
    });

    on<DashboardFilterAlbumEvent>((event, emit) async {
      DashboardState state = this.state;

      if (state is DashboardLoadedState) {
        emit(const DashboardLoadingState());

        try {
          List<Album> albums = await albumFacade.getAllAlbums(false);

          emit(DashboardLoadedState(
            filterAlbums(albums, state.search, event.filter, event.lentFilter),
            state.search,
            event.filter,
            event.lentFilter,
          ));
        } catch (e) {
          if (e is CDOrganizerError) {
            emit(DashboardErrorState(e.message));
          }
          emit(DashboardErrorState(UnknownServerError().message));
        }
      }
    });
  }
}

List<Album> filterAlbums(
  List<Album> albums,
  String? search,
  Set<MediaTypeFilter> filter,
  Set<LentFilter> lentFilter,
) {
  albums.sort((a, b) => a.title.compareTo(b.title));
  albums = albums
      .where((album) => filter.any((filter) =>
          album.type.toLowerCase().contains(filter.name) ||
          (filter == MediaTypeFilter.other &&
              !MediaTypeFilter.values.any((element) =>
                  album.type.toLowerCase().contains(element.name)))))
      .toList();

  albums = albums
      .where((album) =>
          (album.isLent() && lentFilter.contains(LentFilter.lent) ||
              (!album.isLent() && lentFilter.contains(LentFilter.notLent))))
      .toList();

  albums = search != null
      ? albums
          .where((album) =>
              album.title.toLowerCase().contains(search.toLowerCase()) ||
              album.artists.any((artist) =>
                  artist.toLowerCase().contains(search.toLowerCase())))
          .toList()
      : albums;
  return albums;
}

enum MediaTypeFilter {
  vinyl,
  cd,
  other,
}

enum LentFilter {
  notLent,
  lent,
}
