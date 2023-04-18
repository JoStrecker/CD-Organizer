part of 'scanner_bloc.dart';

@immutable
abstract class ScannerState {
  const ScannerState();
}

class ScannerInitialState extends ScannerState {
  const ScannerInitialState();
}

class ScannerControlledState extends ScannerState {
  final TextEditingController controller;

  const ScannerControlledState(this.controller);
}

class ScannerLoadedState extends ScannerControlledState {
  const ScannerLoadedState(TextEditingController controller)
      : super(controller);
}

class ScannerResultState extends ScannerControlledState {
  final List<Release> results;

  const ScannerResultState(this.results, TextEditingController controller)
      : super(controller);
}

class ScannerLoadingState extends ScannerState {
  const ScannerLoadingState();
}

class ScannerErrorState extends ScannerControlledState {
  final String errorMessage;

  const ScannerErrorState(this.errorMessage, TextEditingController controller)
      : super(controller);
}
