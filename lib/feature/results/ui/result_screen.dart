import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_collection/feature/empty/ui/empty_screen.dart';
import 'package:music_collection/feature/error/ui/error_screen.dart';
import 'package:music_collection/feature/loading/ui/loading_screen.dart';
import 'package:music_collection/feature/music_api/domain/release.dart';
import 'package:music_collection/feature/results/application/result_bloc.dart';
import 'package:music_collection/feature/results/ui/widgets/result_item.dart';
import 'package:music_collection/injection_container.dart';

class ResultScreen extends StatelessWidget {
  final List<Release> releases;
  final String query;
  final int pageCount;
  final bool wishlist;

  const ResultScreen({
    super.key,
    required this.releases,
    required this.query,
    required this.pageCount,
    required this.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResultBloc>(
      create: (context) => sl<ResultBloc>()
        ..add(ResultLoadEvent(
          releases,
          query,
        )),
      child: BlocBuilder<ResultBloc, ResultState>(
        builder: (context, state) {
          if (state is ResultLoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                controller: state.controller,
                itemCount: releases.length + 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: index < releases.length
                        ? ResultItem(
                            release: releases[index],
                            index: index,
                            wishlist: wishlist,
                          )
                        : state.page < pageCount
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox(
                                height: 8,
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
