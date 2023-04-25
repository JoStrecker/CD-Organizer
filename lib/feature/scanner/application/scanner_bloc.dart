import 'package:bloc/bloc.dart';
import 'package:music_collection/core/domain/errors/music_collection_error.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/feature/albums/domain/i_album_facade.dart';
import 'package:music_collection/feature/music_api/domain/release.dart';
import 'package:music_collection/feature/music_api/domain/i_music_api_facade.dart';
import 'package:flutter/material.dart';

part 'scanner_event.dart';

part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  IMusicAPIFacade musicAPIFacade;
  IAlbumFacade albumFacade;

  ScannerBloc({required this.musicAPIFacade, required this.albumFacade})
      : super(const ScannerInitialState()) {
    on<ScannerLoadEvent>(
        (event, emit) => {emit(ScannerLoadedState(TextEditingController()))});

    on<ScannerScanCodeEvent>((event, emit) async {
      ScannerState state = this.state;

      if (state is ScannerControlledState) {
        emit(const ScannerLoadingState());

        if (event.code.isEmpty || event.code == '-1') {
          emit(ScannerLoadedState(state.controller));
          return;
        }

        try {
          List<Release> releases =
              await musicAPIFacade.searchByBarcode(barcode: event.code);
          if (releases.isEmpty) {
            emit(ScannerLoadedState(state.controller));
          } else {
            releases.sort((a, b) => a.title.compareTo(b.title));
            emit(ScannerResultState(releases, state.controller));
          }
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(ScannerErrorState(e.message, state.controller));
          }
          emit(ScannerErrorState(
              UnknownServerError().message, state.controller));
        }
      }
    });

    on<ScannerSearchAlbumEvent>((event, emit) async {
      ScannerState state = this.state;

      if (state is ScannerControlledState) {
        emit(const ScannerLoadingState());

        if (event.query.isEmpty) {
          emit(this.state);
          return;
        }

        try {
          List<Release> releases =
              await musicAPIFacade.searchByQuery(query: event.query);

          if (releases.isEmpty) {
            emit(ScannerLoadedState(state.controller));
          } else {
            releases.sort((a, b) => a.title.compareTo(b.title));
            emit(ScannerResultState(releases, state.controller));
          }
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(ScannerErrorState(e.message, state.controller));
          }
          emit(ScannerErrorState(
              UnknownServerError().message, state.controller));
        }
      }
    });

    on<ScannerClearSearchEvent>((event, emit) {
      ScannerState state = this.state;

      if (state is ScannerControlledState) {
        state.controller.clear();
        emit(state);
      }
    });
  }
}
