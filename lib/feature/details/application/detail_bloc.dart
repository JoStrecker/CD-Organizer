import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_api_facade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final IAlbumFacade albumFacade;
  final IMusicAPIFacade musicAPIFacade;

  DetailBloc({required this.albumFacade, required this.musicAPIFacade})
      : super(const DetailInitialState()) {
    on<DetailLoadEvent>((event, emit) async {
      emit(const DetailLoadingState());

      try {
        double? price =
            await musicAPIFacade.getCurrentPriceForID(id: event.album.id);

        emit(DetailLoadedState(
          event.album,
          price: price,
        ));
      } catch (e) {
        emit(DetailLoadedState(event.album));
      }
    });

    on<DetailDeleteEvent>((event, emit) async {
      DetailState state = this.state;

      if (state is DetailLoadedState) {
        emit(const DetailLoadingState());

        try {
          await albumFacade.deleteAlbum(state.album);
        } catch (e) {
          if (e is CDOrganizerError) {
            emit(DetailErrorState(e.message));
          }
          emit(DetailErrorState(UnknownServerError().message));
        }
      }
    });

    on<DetailLendEvent>((event, emit) async {
      DetailState state = this.state;

      if (state is DetailLoadedState) {
        emit(const DetailLoadingState());

        try {
          await albumFacade.lendAlbum(state.album, event.lendee);
          Album newAlbum =
              await albumFacade.getAlbum(state.album.id) ?? state.album;

          emit(state.copyWith(album: newAlbum));
        } catch (e) {
          emit(state);
        }
      }
    });

    on<DetailGotBackEvent>((event, emit) async {
      DetailState state = this.state;

      if (state is DetailLoadedState) {
        emit(const DetailLoadingState());

        try {
          await albumFacade.gotBackAlbum(state.album);
          Album newAlbum =
              await albumFacade.getAlbum(state.album.id) ?? state.album;

          emit(state.copyWith(album: newAlbum));
        } catch (e) {
          emit(state);
        }
      }
    });
  }
}
