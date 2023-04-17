import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final IAlbumFacade albumFacade;

  DetailBloc({required this.albumFacade}) : super(const DetailInitialState()) {
    on<DetailLoadEvent>((event, emit) {
      emit(DetailLoadedState(event.album));
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
  }
}
