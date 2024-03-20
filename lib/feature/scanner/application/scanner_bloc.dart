import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/core/domain/errors/music_collection_error.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/feature/albums/domain/i_album_facade.dart';
import 'package:music_collection/feature/music_api/domain/i_music_api_facade.dart';
import 'package:music_collection/feature/music_api/domain/release.dart';
import 'package:music_collection/feature/music_api/domain/release_initial.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final IMusicAPIFacade musicAPIFacade;
  final IAlbumFacade albumFacade;

  ScannerBloc({
    required this.musicAPIFacade,
    required this.albumFacade,
  }) : super(const ScannerInitialState()) {
    on<ScannerLoadEvent>(
      (event, emit) => emit(ScannerLoadedState(TextEditingController())),
    );

    on<ScannerScanCodeEvent>((event, emit) async {
      ScannerState state = this.state;

      if (state is ScannerControlledState) {
        emit(const ScannerLoadingState());

        if (event.code.isEmpty || event.code == '-1') {
          emit(ScannerLoadedState(state.controller));
          return;
        }

        try {
          ReleaseInitial releaseInitial = await musicAPIFacade.searchByBarcode(
            barcode: event.code,
          );

          if (releaseInitial.results.isEmpty) {
            emit(ScannerLoadedState(state.controller));
          } else {
            state.controller.clear();
            emit(ScannerResultState(
              releaseInitial.results,
              releaseInitial.pages,
              state.controller,
            ));
          }
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(ScannerErrorState(e.message, state.controller));
          }
          emit(
            ScannerErrorState(UnknownServerError().message, state.controller),
          );
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
          ReleaseInitial releaseInitial = await musicAPIFacade.searchByQuery(
            query: event.query,
          );

          if (releaseInitial.results.isEmpty) {
            emit(ScannerLoadedState(state.controller));
          } else {
            emit(ScannerResultState(
              releaseInitial.results,
              releaseInitial.pages,
              state.controller,
            ));
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
