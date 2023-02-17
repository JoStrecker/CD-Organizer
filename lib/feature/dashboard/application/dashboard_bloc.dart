import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/music_api/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  IAlbumFacade albumFacade;

  DashboardBloc({required this.albumFacade})
      : super(const DashboardInitialState()) {
    on<DashboardLoadEvent>((event, emit) async {
      emit(const DashboardLoadingState());

      try {
        List<Release> albums =
            await albumFacade.searchByArtist(artistName: 'Queen');
        if (albums.isEmpty) {
          emit(const DashboardEmptyState());
        }else{
          emit(DashboardLoadedState(albums));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
          emit(DashboardErrorState(e.message));
        }
        emit(DashboardErrorState(UnknownServerError().message));
      }
    });
  }
}
