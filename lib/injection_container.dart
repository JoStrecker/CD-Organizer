import 'package:get_it/get_it.dart';
import 'package:music_collection/feature/albums/domain/i_album_facade.dart';
import 'package:music_collection/feature/albums/infrastructure/hive_album_facade.dart';
import 'package:music_collection/feature/dashboard/application/dashboard_bloc.dart';
import 'package:music_collection/feature/details/application/detail_bloc.dart';
import 'package:music_collection/feature/music_api/domain/i_music_api_facade.dart';
import 'package:music_collection/feature/music_api/infrastructure/dio_discogs_facade.dart';
import 'package:music_collection/feature/results/application/result_bloc.dart';
import 'package:music_collection/feature/scanner/application/scanner_bloc.dart';
import 'package:music_collection/feature/wishlist/application/wishlist_bloc.dart';

final sl = GetIt.instance;

/// Method to initialize all objects for dependency injection
/// Use sl.registerSingleton for Singletons
/// Use sl.registerFactory for Factories (get new object on call)
void initInjection() {
  //Facades
  sl.registerFactory<IMusicAPIFacade>(() => DioDiscogsFacade());
  sl.registerFactory<IAlbumFacade>(() => HiveAlbumFacade());

  //Bloc
  sl.registerFactory<DashboardBloc>(() => DashboardBloc(
        albumFacade: sl<IAlbumFacade>(),
      ));
  sl.registerFactory<ResultBloc>(() => ResultBloc(
        musicApiFacade: sl<IMusicAPIFacade>(),
        albumFacade: sl<IAlbumFacade>(),
      ));
  sl.registerFactory<ScannerBloc>(() => ScannerBloc(
        musicAPIFacade: sl<IMusicAPIFacade>(),
        albumFacade: sl<IAlbumFacade>(),
      ));
  sl.registerFactory<DetailBloc>(() => DetailBloc(
        albumFacade: sl<IAlbumFacade>(),
        musicAPIFacade: sl<IMusicAPIFacade>(),
      ));
  sl.registerFactory<WishlistBloc>(() => WishlistBloc(
        albumFacade: sl<IAlbumFacade>(),
      ));
}
