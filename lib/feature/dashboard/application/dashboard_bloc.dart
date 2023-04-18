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
        List<Album> albums = await albumFacade.getAllAlbums();
        albums.sort((a, b) => a.title.compareTo(b.title));

        if (albums.isEmpty) {
          emit(const DashboardEmptyState());
        } else {
          emit(DashboardLoadedState(albums, MediaTypeFilter.all, null));
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

      if (state is DashboardLoadedState) {
        emit(const DashboardLoadingState());

        if (event.reload ?? false) {
          try {
            List<Album> albums = await albumFacade.getAllAlbums();
            albums.sort((a, b) => a.title.compareTo(b.title));
            albums = state.filter == MediaTypeFilter.vinyl
                ? albums.where((album) => album.type.contains('Vinyl')).toList()
                : state.filter == MediaTypeFilter.cd
                    ? albums
                        .where((album) => album.type.contains('CD'))
                        .toList()
                    : albums;
            albums = state.search != null
                ? albums
                    .where((album) =>
                        album.title.contains(state.search!) ||
                        album.artists
                            .any((artist) => artist.contains(state.search!)))
                    .toList()
                : albums;

            if (albums.isEmpty) {
              emit(const DashboardEmptyState());
            } else {
              emit(DashboardLoadedState(
                albums,
                state.filter,
                state.search,
              ));
            }
          } catch (e) {
            if (e is CDOrganizerError) {
              emit(DashboardErrorState(e.message));
            }
            emit(DashboardErrorState(UnknownServerError().message));
          }
        }
      }
    });

    on<DashboardDeleteAlbumEvent>((event, emit) async {
      DashboardState state = this.state;

      if (state is DashboardLoadedState) {
        emit(const DashboardLoadingState());

        try {
          await albumFacade.deleteAlbum(event.selectedAlbum);

          List<Album> albums = await albumFacade.getAllAlbums();
          albums.sort((a, b) => a.title.compareTo(b.title));
          albums = state.filter == MediaTypeFilter.vinyl
              ? albums.where((album) => album.type.contains('Vinyl')).toList()
              : state.filter == MediaTypeFilter.cd
                  ? albums.where((album) => album.type.contains('CD')).toList()
                  : albums;
          albums = state.search != null
              ? albums
                  .where((album) =>
                      album.title.contains(state.search!) ||
                      album.artists
                          .any((artist) => artist.contains(state.search!)))
                  .toList()
              : albums;

          if (albums.isEmpty) {
            emit(const DashboardEmptyState());
          } else {
            emit(DashboardLoadedState(albums, state.filter, state.search));
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
          List<Album> albums = await albumFacade.getAllAlbums();
          albums.sort((a, b) => a.title.compareTo(b.title));
          albums = state.filter == MediaTypeFilter.vinyl
              ? albums.where((album) => album.type.contains('Vinyl')).toList()
              : state.filter == MediaTypeFilter.cd
                  ? albums.where((album) => album.type.contains('CD')).toList()
                  : albums;
          albums = albums
              .where((album) =>
                  album.title.contains(event.search) ||
                  album.artists.any((artist) => artist.contains(event.search)))
              .toList();

          emit(DashboardLoadedState(
            albums,
            state.filter,
            event.search,
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
          List<Album> albums = await albumFacade.getAllAlbums();
          albums.sort((a, b) => a.title.compareTo(b.title));
          albums = event.filter == MediaTypeFilter.vinyl
              ? albums.where((album) => album.type.contains('Vinyl')).toList()
              : event.filter == MediaTypeFilter.cd
                  ? albums.where((album) => album.type.contains('CD')).toList()
                  : albums;
          albums = state.search != null
              ? albums
                  .where((album) =>
                      album.title.contains(state.search!) ||
                      album.artists
                          .any((artist) => artist.contains(state.search!)))
                  .toList()
              : albums;

          emit(DashboardLoadedState(albums, event.filter, state.search));
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

enum MediaTypeFilter {
  all,
  vinyl,
  cd,
}
