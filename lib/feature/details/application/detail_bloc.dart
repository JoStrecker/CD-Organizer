import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/core/domain/errors/music_collection_error.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/albums/domain/i_album_facade.dart';
import 'package:music_collection/feature/music_api/domain/i_music_api_facade.dart';
import 'package:music_collection/feature/notifications/application/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final IAlbumFacade albumFacade;
  final IMusicAPIFacade musicAPIFacade;

  DetailBloc({
    required this.albumFacade,
    required this.musicAPIFacade,
  }) : super(const DetailInitialState()) {
    on<DetailLoadEvent>((event, emit) async {
      emit(const DetailLoadingState());

      try {
        Album? album = await albumFacade.getAlbum(event.albumId);

        if (album == null) {
          emit(const DetailErrorState('no such Album!'));
          return;
        }

        emit(DetailLoadedState(album));
      } catch (e) {
        emit(DetailErrorState(UnknownServerError().message));
      }
    });

    on<DetailDeleteEvent>((event, emit) async {
      DetailState state = this.state;

      if (state is DetailLoadedState) {
        emit(const DetailLoadingState());

        try {
          await albumFacade.deleteAlbum(state.album);

          emit(const DetailLoadingState());
        } catch (e) {
          if (e is MusicCollectionError) {
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

          //schedule Notification
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool granted = prefs.getBool('sendNotifications') ?? false;

          if (granted) {
            DateTime now = DateTime.now();
            showNotificationWithActions(
              title: 'Return Album',
              text:
                  '${state.album.title} has been loaned to ${event.lendee} since ${now.day}.${now.month}.${now.year}.',
              id: int.parse(state.album.id),
            );
          }

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

          cancelNotification(int.parse(state.album.id));

          emit(state.copyWith(album: newAlbum));
        } catch (e) {
          emit(state);
        }
      }
    });

    on<DetailChangeLocationEvent>((event, emit) async {
      DetailState state = this.state;

      if (state is DetailLoadedState) {
        emit(const DetailLoadingState());

        try {
          await albumFacade.updateAlbum(
            state.album,
            state.album.copyWith(location: event.newLocation),
          );

          Album newAlbum =
              await albumFacade.getAlbum(state.album.id) ?? state.album;

          emit(state.copyWith(album: newAlbum));
        } catch (e) {
          emit(state);
        }
      }
    });

    on<DetailAddCollectionEvent>((event, emit) async {
      DetailState state = this.state;

      if (state is DetailLoadedState) {
        emit(const DetailLoadingState());

        try {
          await albumFacade.updateAlbum(
              state.album, state.album.copyWith(wishlist: false));

          emit(const DetailLoadingState());
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(DetailErrorState(e.message));
          }
          emit(DetailErrorState(UnknownServerError().message));
        }
      }
    });
  }
}
