part of 'scanner_bloc.dart';

@immutable
abstract class ScannerState {
  const ScannerState();
}

class ScannerInitialState extends ScannerState {
  const ScannerInitialState();
}

class ScannerLoadedState extends ScannerState {
  final List<Release> results;

  const ScannerLoadedState(this.results);
}

class ScannerLoadingState extends ScannerState {
  const ScannerLoadingState();
}

class ScannerErrorState extends ScannerState {
  final String errorMessage;

  const ScannerErrorState(this.errorMessage);
}
