import 'package:cd_organizer/feature/empty/ui/empty_screen.dart';
import 'package:cd_organizer/feature/error/ui/error_screen.dart';
import 'package:cd_organizer/feature/loading/ui/loading_screen.dart';
import 'package:cd_organizer/feature/music_api/domain/release.dart';
import 'package:cd_organizer/feature/results/application/result_bloc.dart';
import 'package:cd_organizer/feature/results/ui/widgets/result_item.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatelessWidget {
  final List<Release> releases;
  final bool wishlist;

  const ResultScreen(
      {super.key, required this.releases, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultBloc>(
      create: (context) => sl<ResultBloc>()..add(ResultLoadEvent(releases)),
      child: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          if (state is ResultLoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: releases.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: ResultItem(
                      release: releases[index],
                      index: index,
                      wishlist: wishlist,
                    ),
                  );
                },
              ),
            );
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
