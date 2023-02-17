import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:cd_organizer/feature/music_api/domain/i_album_facade.dart';
import 'package:cd_organizer/feature/music_api/infrastructure/dio_album_facade.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// Method to initialize all objects for dependency injection
/// Use sl.registerSingleton for Singletons
/// Use sl.registerFactory for Factories (get new object on call)
void initInjection() {
  //Facades
  sl.registerFactory<IAlbumFacade>(() => DioAlbumFacade());

  //Bloc
  sl.registerFactory<DashboardBloc>(() => DashboardBloc(albumFacade: sl<IAlbumFacade>()));
}
