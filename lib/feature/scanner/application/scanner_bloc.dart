import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_brainz_facade.dart';
import 'package:meta/meta.dart';

part 'scanner_event.dart';

part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  IMusicBrainzFacade musicBrainzFacade;
  IAlbumFacade albumFacade;

  ScannerBloc({required this.musicBrainzFacade, required this.albumFacade})
      : super(const ScannerInitialState()) {
    on<ScannerScanCodeEvent>((event, emit) async {
      emit(const ScannerLoadingState());

      if(event.code.isEmpty || event.code == '-1'){
        emit(const ScannerInitialState());
        return;
      }

      try {
        List<Release> releases =
            await musicBrainzFacade.searchByBarcode(barcode: event.code);
        if (releases.isEmpty) {
          emit(const ScannerInitialState());
        } else {
          releases.sort((a,b) => a.title.compareTo(b.title));
          emit(ScannerLoadedState(releases));
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
        List<Release> albumResults = await musicBrainzFacade.searchByAlbumTitle(albumTitle: event.query);
        List<Release> artistResults = await musicBrainzFacade.searchByArtist(artistName: event.query);
        List<Release> releases = List.of([...albumResults, ...artistResults.where((res) => albumResults.every((element) => element.id != res.id))]);
        if (releases.isEmpty) {
          emit(const ScannerInitialState());
        } else {
          releases.sort((a,b) => a.title.compareTo(b.title));
          emit(ScannerLoadedState(releases));
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
