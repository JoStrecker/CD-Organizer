import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
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
        List<Album> albums =
            await albumFacade.getAllAlbums();
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

    on<DashboardSelectAlbumEvent>((event, emit){
      if(state is DashboardLoadedState){
        emit(DashboardLoadedDetailState(event.selectedAlbum));
      }
    });
  }
}
