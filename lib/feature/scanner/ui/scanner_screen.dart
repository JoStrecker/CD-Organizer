import 'package:cd_organizer/feature/empty/ui/empty_screen.dart';
import 'package:cd_organizer/feature/error/ui/error_screen.dart';
import 'package:cd_organizer/feature/loading/ui/loading_screen.dart';
import 'package:cd_organizer/feature/results/application/result_bloc.dart';
import 'package:cd_organizer/feature/results/ui/result_screen.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultBloc>(
      create: (context) => sl<ResultBloc>()..add(const ResultLoadEvent()),
      child: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          if (state is ResultLoadedState) {
            return ResultScreen(releases: state.releases);
          } else if (state is ResultLoadingState) {
            return const LoadingScreen();
          } else if (state is ResultEmptyState) {
            return const EmptyScreen();
          } else if (state is ResultErrorState) {
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
