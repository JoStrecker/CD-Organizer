import 'package:music_collection/feature/details/application/detail_bloc.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_loaded_screen.dart';
import 'package:music_collection/feature/details/ui/widgets/detail_loaded_screen_landscape.dart';
import 'package:music_collection/feature/error/ui/error_screen.dart';
import 'package:music_collection/feature/loading/ui/loading_screen.dart';
import 'package:music_collection/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop(true);
        return false;
      },
      child: BlocProvider<DetailBloc>(
        create: (context) => sl<DetailBloc>()..add(DetailLoadEvent(id)),
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoadedState) {
              return OrientationBuilder(builder: (context, orientation) {
                return _isPortrait(orientation, context)
                    ? DetailLoadedScreen(album: state.album)
                    : DetailLoadedScreenLandscape(album: state.album);
              });
            } else if (state is DetailLoadingState) {
              return const LoadingScreen();
            } else if (state is DetailErrorState) {
              return ErrorScreen(
                message: state.message,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  bool _isPortrait(Orientation orientation, BuildContext ctx){
    if(orientation == Orientation.portrait){
      return true;
    }else{
      if(MediaQuery.of(ctx).size.width < 750){
        return true;
      }else{
        return false;
      }
    }
  }
}
