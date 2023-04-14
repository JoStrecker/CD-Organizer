part of 'scanner_bloc.dart';

@immutable
abstract class ScannerEvent {
  const ScannerEvent();
}

class ScannerScanCodeEvent extends ScannerEvent{
  final String code;

  const ScannerScanCodeEvent(this.code);
}
