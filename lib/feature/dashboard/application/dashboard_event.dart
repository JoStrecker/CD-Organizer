part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardLoadEvent extends DashboardEvent {
  const DashboardLoadEvent();
}

class DashboardSelectAlbumEvent extends DashboardEvent {
  final int selectedAlbum;

  const DashboardSelectAlbumEvent(
    this.selectedAlbum,
  );
}
