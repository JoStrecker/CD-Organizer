import 'package:cd_organizer/feature/albums/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/albums/infrastructure/hive_album_facade.dart';
import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:cd_organizer/feature/music_api/domain/i_music_brainz_facade.dart';
import 'package:cd_organizer/feature/music_api/infrastructure/dio_music_brainz_facade.dart';
import 'package:cd_organizer/feature/results/application/result_bloc.dart';
import 'package:cd_organizer/feature/search/application/search_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// Method to initialize all objects for dependency injection
/// Use sl.registerSingleton for Singletons
/// Use sl.registerFactory for Factories (get new object on call)
void initInjection() {
  //Facades
  sl.registerFactory<IMusicBrainzFacade>(() => DioMusicBrainzFacade());
  sl.registerFactory<IAlbumFacade>(() => HiveAlbumFacade());

  //Bloc
  sl.registerFactory<SearchBloc>(() => SearchBloc(
        albumFacade: sl<IMusicBrainzFacade>(),
      ));
  sl.registerFactory<DashboardBloc>(() => DashboardBloc(
        albumFacade: sl<IAlbumFacade>(),
      ));
  sl.registerFactory<ResultBloc>(() => ResultBloc(
        musicBrainzFacade: sl<IMusicBrainzFacade>(),
        albumFacade: sl<IAlbumFacade>(),
      ));
}
