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
          emit(DashboardLoadedState(albums));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
          emit(DashboardErrorState(e.message));
        }
        emit(DashboardErrorState(UnknownServerError().message));
      }
    });

    on<DashboardRefreshEvent>((event, emit) async {
      emit(const DashboardLoadingState());

      try {
        List<Album> albums = await albumFacade.getAllAlbums();
        albums.sort((a, b) => a.title.compareTo(b.title));
        if (albums.isEmpty) {
          emit(const DashboardEmptyState());
        } else {
          emit(DashboardLoadedState(albums));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
          emit(DashboardErrorState(e.message));
        }
        emit(DashboardErrorState(UnknownServerError().message));
      }
    });

    on<DashboardSelectAlbumEvent>((event, emit) {
      if (state is DashboardLoadedState) {
        emit(DashboardLoadedDetailState(event.selectedAlbum));
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

          if (albums.isEmpty) {
            emit(const DashboardEmptyState());
          } else {
            emit(DashboardLoadedState(albums));
          }
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
