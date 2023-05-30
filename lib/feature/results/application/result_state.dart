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

  const ResultLoadedState(
    this.releases,
    this.query,
    this.controller,
    this.page,
  );

  ResultLoadedState copyWith({
    List<Release>? releases,
    String? query,
    ScrollController? controller,
    int? page,
  }) {
    return ResultLoadedState(
      releases ?? this.releases,
      query ?? this.query,
      controller ?? this.controller,
      page ?? this.page,
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
