import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_api_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:path_provider/path_provider.dart';

part 'result_event.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  IMusicAPIFacade musicApiFacade;
  IAlbumFacade albumFacade;

  ResultBloc({required this.musicApiFacade, required this.albumFacade})
      : super(const ResultInitialState()) {
    on<ResultLoadEvent>((event, emit) async {
      emit(const ResultLoadingState());

      emit(ResultLoadedState(event.result));
    });

    on<ResultSelectAlbumEvent>((event, emit) async {
      var state = this.state;
      if (state is ResultLoadedState) {
        List<Release> releases = state.releases;
        Release selected = event.selectedAlbum;

        emit(const ResultLoadingState());

        try {
          String? coverArt;

          if(selected.coverArt != null){
            Directory dir = await getApplicationDocumentsDirectory();
            coverArt ='${dir.path}/${selected.id}';
            File image = File(coverArt);
            var response = await http.get(selected.coverArt!);
            await image.writeAsBytes(response.bodyBytes);
          }

          Album newAlbum = await musicApiFacade.getAlbumForID(id: selected.id);
          newAlbum.coverArt = coverArt;

          await albumFacade.addAlbum(newAlbum);

          releases.removeWhere((element) => element.id == selected.id);
          emit(state.copyWith(releases: releases));
        } catch (e) {
          if (e is CDOrganizerError) {
            emit(ResultErrorState(e.message));
          }
          emit(ResultErrorState(UnknownServerError().message));
        }
      }
    });
  }
}
