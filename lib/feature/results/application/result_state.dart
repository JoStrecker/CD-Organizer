part of 'result_bloc.dart';

@immutable
abstract class ResultState {
  const ResultState();
}

class ResultInitialState extends ResultState {
  const ResultInitialState();
}

class ResultLoadingState extends ResultState {
  const ResultLoadingState();
}

class ResultLoadedState extends ResultState {
  final List<Release> releases;
  final String query;
  final ScrollController controller;
  final int page;

  const ResultLoadedState({
    required this.releases,
    required this.controller,
    required this.page,
    required this.query,
  });

  ResultLoadedState copyWith({
    List<Release>? releases,
    String? query,
    ScrollController? controller,
    int? page,
  }) {
    return ResultLoadedState(
      releases: releases ?? this.releases,
      controller: controller ?? this.controller,
      page: page ?? this.page,
      query: query ?? this.query,
    );
  }
}

class ResultEmptyState extends ResultState {
  const ResultEmptyState();
}

class ResultErrorState extends ResultState {
  final String errorMessage;

  const ResultErrorState(
    this.errorMessage,
  );
}
