import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_api_facade.dart';
import 'package:flutter/foundation.dart';

part 'scanner_event.dart';

part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  IMusicAPIFacade musicAPIFacade;
  IAlbumFacade albumFacade;

  ScannerBloc({required this.musicAPIFacade, required this.albumFacade})
      : super(const ScannerInitialState()) {
    on<ScannerScanCodeEvent>((event, emit) async {
      emit(const ScannerLoadingState());

      if(event.code.isEmpty || event.code == '-1'){
        emit(const ScannerInitialState());
        return;
      }

      try {
        List<Release> releases =
            await musicAPIFacade.searchByBarcode(barcode: event.code);
        if (releases.isEmpty) {
          emit(const ScannerInitialState());
        } else {
          releases.sort((a,b) => a.title.compareTo(b.title));
          emit(ScannerResultState(releases, null));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
          emit(ScannerErrorState(e.message));
        }
        emit(ScannerErrorState(UnknownServerError().message));
      }
    });

    on<ScannerSearchAlbumEvent>((event, emit) async {
      emit(const ScannerLoadingState());

      if(event.query.isEmpty){
        emit(const ScannerInitialState());
        return;
      }

      try {
        List<Release> releases = await musicAPIFacade.searchByQuery(query: event.query);

        if (releases.isEmpty) {
          emit(const ScannerInitialState());
        } else {
          releases.sort((a,b) => a.title.compareTo(b.title));
          emit(ScannerResultState(releases, event.query));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
          emit(ScannerErrorState(e.message));
        }
        emit(ScannerErrorState(UnknownServerError().message));
      }
    });
  }
}
