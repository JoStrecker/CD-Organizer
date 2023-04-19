import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/details/application/detail_bloc.dart';
import 'package:cd_organizer/feature/details/ui/widgets/detail_loaded_screen.dart';
import 'package:cd_organizer/feature/error/ui/error_screen.dart';
import 'package:cd_organizer/feature/loading/ui/loading_screen.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  final Album album;

  const DetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop(true);
        return false;
      },
      child: BlocProvider<DetailBloc>(
        create: (context) => sl<DetailBloc>()..add(DetailLoadEvent(album)),
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoadedState) {
              return DetailLoadedScreen(album: state.album);
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
}
