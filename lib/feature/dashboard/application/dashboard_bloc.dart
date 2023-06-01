import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:music_collection/core/domain/errors/music_collection_error.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/albums/domain/i_album_facade.dart';
import 'package:music_collection/feature/music_api/domain/i_music_api_facade.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final IAlbumFacade albumFacade;
  final IMusicAPIFacade musicAPIFacade;

  DashboardBloc({
    required this.albumFacade,
    required this.musicAPIFacade,
  }) : super(const DashboardInitialState()) {
    on<DashboardLoadEvent>((event, emit) async {
      emit(const DashboardLoadingState());

      try {
        List<Album> albums = await albumFacade.getAllAlbums(false);

        if (albums.isEmpty) {
          emit(const DashboardEmptyState());
        } else {
          ScrollController controller = ScrollController();
          controller.addListener(() {
            add(const DashboardScrollAlbumListEvent());
          });

          DateTime lastDate = DateTime.now().add(
            const Duration(days: 14),
          );
          List<Album> updateableAlbums = albums.where(
                (album) => album.lastUpdated.isAfter(lastDate),
              ).toList();

          try {
            List<Album> updatedAlbums = List.empty(growable: true);
            for (var album in updateableAlbums) {
              updatedAlbums.add(
                await musicAPIFacade.getAlbumForID(id: album.id),
              );
            }

            albums.removeWhere(
              (album) => album.lastUpdated.isAfter(lastDate),
            );
            albums.addAll(updatedAlbums);
          } catch(e){}

          albums.sort((a, b) => a.title.compareTo(b.title));

          emit(DashboardLoadedState(
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
              emit(state.copyWith(
                albums: filterAlbums(
                  albums,
                  state.search,
                  state.filter,
                  state.lentFilter,
                ),
              ));
            }
          } else if (state is DashboardEmptyState) {
            if (albums.isEmpty) {
              emit(const DashboardEmptyState());
            } else {
              ScrollController controller = ScrollController();
              controller.addListener(() {
                add(const DashboardScrollAlbumListEvent());
              });
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
                controller,
                true,
              ));
            }
          } else {
            emit(state);
          }
        } catch (e) {
          if (e is MusicCollectionError) {
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
            emit(DashboardErrorState(e.message));
          }
          emit(DashboardErrorState(UnknownServerError().message));
        }
      }
    });

    on<DashboardScrollAlbumListEvent>((event, emit) {
      DashboardState state = this.state;

      if (state is DashboardLoadedState) {
        emit(state.copyWith(isAtTop: state.controller.offset == 0));
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
      .where(
        (album) => (album.isLent() && lentFilter.contains(LentFilter.lent) ||
            (!album.isLent() && lentFilter.contains(LentFilter.notLent))),
      )
      .toList();

  albums = search != null
      ? albums
          .where(
            (album) =>
                album.title.toLowerCase().contains(search.toLowerCase()) ||
                album.artists.any(
                  (artist) =>
                      artist.toLowerCase().contains(search.toLowerCase()),
                ),
          )
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
