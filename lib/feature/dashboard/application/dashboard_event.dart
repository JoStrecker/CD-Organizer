part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardLoadEvent extends DashboardEvent {
  const DashboardLoadEvent();
}

class DashboardSelectAlbumEvent extends DashboardEvent {
  final Album selectedAlbum;

  const DashboardSelectAlbumEvent(
    this.selectedAlbum,
  );
}

class DashboardDeleteAlbumEvent extends DashboardEvent {
  final Album selectedAlbum;

  const DashboardDeleteAlbumEvent(
    this.selectedAlbum,
  );
}

class DashboardRefreshEvent extends DashboardEvent {
  const DashboardRefreshEvent();
}

class DashboardSearchAlbumEvent extends DashboardEvent {
  final String search;

  const DashboardSearchAlbumEvent(
    this.search,
  );
}

class DashboardFilterAlbumEvent extends DashboardEvent {
  final MediaTypeFilter filter;

  const DashboardFilterAlbumEvent(
    this.filter,
  );
}
