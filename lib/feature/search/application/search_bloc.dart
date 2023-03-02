import 'package:bloc/bloc.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_brainz_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  IMusicBrainzFacade albumFacade;

  SearchBloc({required this.albumFacade}) : super(const SearchInitial()) {
    on<SearchChangedEvent>((event, emit) async {
      try {
        List<Release> albums =
        await albumFacade.searchByArtist(artistName: event.text);
        if (albums.isEmpty) {
          emit(const SearchEmptyState());
        }else{
          emit(SearchResultState(albums));
        }
      } catch (e) {
        emit(const SearchEmptyState());
      }

      if (event.text.isEmpty) {
        return emit(const SearchInitial());
      }
    });
    on<SearchDeleteEvent>((event, emit) => emit(const SearchInitial()));
    //on<SearchFilterEvent>((event, emit) => emit(const SearchInitial()));
  }
}
