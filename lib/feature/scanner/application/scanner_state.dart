part of 'scanner_bloc.dart';

@immutable
abstract class ScannerState {
  const ScannerState();
}

class ScannerInitialState extends ScannerState {
  const ScannerInitialState();
}

class ScannerResultState extends ScannerState {
  final List<Release> results;
  final String? search;

  const ScannerResultState(this.results, this.search);
}

class ScannerLoadingState extends ScannerState {
  const ScannerLoadingState();
}

class ScannerErrorState extends ScannerState {
  final String errorMessage;

  const ScannerErrorState(this.errorMessage);
}
