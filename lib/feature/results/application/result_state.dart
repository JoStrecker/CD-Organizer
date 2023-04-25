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

  const ResultLoadedState(
    this.releases,
  );

  ResultLoadedState copyWith({
    List<Release>? releases,
  }) {
    return ResultLoadedState(
      releases ?? this.releases,
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
