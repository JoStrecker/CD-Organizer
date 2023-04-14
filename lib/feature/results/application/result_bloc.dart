import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cd_organizer/core/application/global_vars.dart';
import 'package:http/http.dart' as http;
import 'package:cd_organizer/core/domain/errors/cd_organizer_error.dart';
import 'package:cd_organizer/core/domain/errors/unknown_server_error.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_brainz_facade.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'result_event.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  IMusicBrainzFacade musicBrainzFacade;
  IAlbumFacade albumFacade;

  ResultBloc({required this.musicBrainzFacade, required this.albumFacade})
      : super(const ResultInitialState()) {
    on<ResultLoadEvent>((event, emit) async {
      emit(const ResultLoadingState());

      emit(ResultLoadedState(event.result));

      /*try {
        List<Release> releases =
            await musicBrainzFacade.searchByArtist(artistName: 'Queen');
        if (releases.isEmpty) {
          emit(const ResultEmptyState());
        } else {
          emit(ResultLoadedState(releases));
        }
      } catch (e) {
        if (e is CDOrganizerError) {
          emit(ResultErrorState(e.message));
        }
        emit(ResultErrorState(UnknownServerError().message));
      }*/
    });

    on<ResultSelectAlbumEvent>((event, emit) async {
      var state = this.state;
      if (state is ResultLoadedState) {
        List<Release> releases = state.releases;
        Release selected = event.selectedAlbum;

        emit(const ResultLoadingState());

        try {
          String? coverArt;

          if(await selected.hasImage()){
            Directory dir = await getApplicationDocumentsDirectory();
            coverArt ='${dir.path}/${selected.id}';
            File image = File(coverArt);
            var response = await http.get(Uri.parse('${coverRootURL}release/${selected.id}/front'));
            await image.writeAsBytes(response.bodyBytes);
          }

          Album newAlbum = Album(
            coverArt: coverArt,
            trackCount: selected.trackCount,
            label: selected.labelInfo?[0].label?.name ?? 'unknown',
            date: DateTime.tryParse(selected.date ?? '') ??
                DateTime.fromMillisecondsSinceEpoch(0),
            mbid: selected.id,
            artists: selected.artistCredit.map((e) => e.name).toList(),
            title: selected.title,
            tracks: await musicBrainzFacade.getTracksForMBID(mbid: selected.id),
          );

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
