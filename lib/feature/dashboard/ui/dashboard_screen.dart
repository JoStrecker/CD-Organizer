import 'package:cd_organizer/feature/dashboard/application/dashboard_bloc.dart';
import 'package:cd_organizer/feature/results/ui/result_screen.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => sl<DashboardBloc>()..add(const DashboardLoadEvent()),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoadedState) {
              return ResultScreen(albums: state.albums);
            } else if (state is DashboardLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DashboardEmptyState) {
              return const Center(
                child: Text('Empty'),
              );
            } else if (state is DashboardErrorState) {
              return Center(
                child: Text(state.errorMessage),
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
