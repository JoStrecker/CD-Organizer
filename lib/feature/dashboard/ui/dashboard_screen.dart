import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:cd_organizer/feature/dashboard/ui/widgets/album_list_screen.dart';
import 'package:cd_organizer/feature/empty/ui/empty_screen.dart';
import 'package:cd_organizer/feature/error/ui/error_screen.dart';
import 'package:cd_organizer/feature/loading/ui/loading_screen.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => sl<DashboardBloc>()..add(const DashboardLoadEvent()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoadedState) {
            return AlbumListScreen(albums: state.albums);
          } else if (state is DashboardLoadingState) {
            return const LoadingScreen();
          } else if (state is DashboardEmptyState) {
            return const EmptyScreen();
          } else if (state is DashboardErrorState) {
            return ErrorScreen(
              message: state.errorMessage,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
