part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardLoadEvent extends DashboardEvent {
  const DashboardLoadEvent();
}

class DashboardDeleteAlbumEvent extends DashboardEvent {
  final Album selectedAlbum;

  const DashboardDeleteAlbumEvent(this.selectedAlbum);
}

class DashboardRefreshEvent extends DashboardEvent {
  final bool? reload;

  const DashboardRefreshEvent(this.reload);
}

class DashboardSearchAlbumEvent extends DashboardEvent {
  final String search;

  const DashboardSearchAlbumEvent(this.search);
}

class DashboardFilterAlbumEvent extends DashboardEvent {
  final Set<MediaTypeFilter> filter;
  final Set<LentFilter> lentFilter;

  const DashboardFilterAlbumEvent(this.filter, this.lentFilter);
}

class DashboardScrollAlbumListEvent extends DashboardEvent {
  final bool atEdge;

  const DashboardScrollAlbumListEvent(this.atEdge);
}
