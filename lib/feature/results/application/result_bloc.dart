import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/core/domain/errors/music_collection_error.dart';
import 'package:music_collection/core/domain/errors/unknown_server_error.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/albums/domain/i_album_facade.dart';
import 'package:music_collection/feature/music_api/domain/i_music_api_facade.dart';
import 'package:music_collection/feature/music_api/domain/release.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final IMusicAPIFacade musicApiFacade;
  final IAlbumFacade albumFacade;

  ResultBloc({
    required this.musicApiFacade,
    required this.albumFacade,
  }) : super(const ResultInitialState()) {
    on<ResultLoadEvent>((event, emit) async {
      emit(const ResultLoadingState());

      ScrollController controller = ScrollController();
      controller.addListener(() {
        if (controller.position.extentAfter == 0) {
          add(const ResultAddAlbumsEvent());
        }
      });

      try {
        List<Album> albums = await albumFacade.getAllAlbums(null);

        emit(ResultLoadedState(
          releases: event.result
            ..removeWhere(
              (release) => albums.any((album) => album.id == release.id),
            ),
          controller: controller,
          page: 1,
          query: event.query,
        ));
      } catch (e) {
        if (e is MusicCollectionError) {
          emit(ResultErrorState(e.message));
        }
        emit(ResultErrorState(UnknownServerError().message));
      }
    });

    on<ResultAddAlbumsEvent>((event, emit) async {
      var state = this.state;

      if (state is ResultLoadedState) {
        if (state.query.isNotEmpty) {
          try {
            List<Album> albums = await albumFacade.getAllAlbums(null);
            List<Release> newReleases = (await musicApiFacade.searchByQuery(
                    query: state.query, page: state.page + 1))
                .results;
            newReleases.removeWhere(
              (release) => albums.any((album) => album.id == release.id),
            );

            emit(state.copyWith(
              releases: state.releases..addAll(newReleases),
              page: state.page + 1,
            ));
          } catch (e) {
            emit(state);
          }
        }
      }
    });

    on<ResultSelectAlbumEvent>((event, emit) async {
      var state = this.state;
      if (state is ResultLoadedState) {
        List<Release> releases = state.releases;
        Release selected = event.selectedAlbum;

        emit(const ResultLoadingState());

        try {
          Uint8List? coverArt = await selected.getCoverArt();

          Album newAlbum = await musicApiFacade.getAlbumForID(id: selected.id);
          newAlbum.coverArt = coverArt;
          newAlbum.coverArtUri = selected.coverArt?.toString();
          newAlbum.wishlist = event.wishlist;

          await albumFacade.addAlbum(newAlbum);

          releases.removeWhere((element) => element.id == selected.id);
          emit(state.copyWith(releases: releases));
        } catch (e) {
          if (e is MusicCollectionError) {
            emit(ResultErrorState(e.message));
          }
          emit(ResultErrorState(UnknownServerError().message));
        }
      }
    });
  }
}
