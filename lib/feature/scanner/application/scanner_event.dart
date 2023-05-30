part of 'scanner_bloc.dart';

@immutable
abstract class ScannerEvent {
  const ScannerEvent();
}

class ScannerLoadEvent extends ScannerEvent {
  const ScannerLoadEvent();
}

class ScannerScanCodeEvent extends ScannerEvent {
  final String code;

  const ScannerScanCodeEvent(
    this.code,
  );
}

class ScannerSearchAlbumEvent extends ScannerEvent {
  final String query;

  const ScannerSearchAlbumEvent(
    this.query,
  );
}

class ScannerClearSearchEvent extends ScannerEvent {
  const ScannerClearSearchEvent();
}
