part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  const DashboardState();
}

class DashboardInitialState extends DashboardState {
  const DashboardInitialState();
}

class DashboardLoadingState extends DashboardState {
  const DashboardLoadingState();
}

class DashboardLoadedState extends DashboardState {
  final List<Album> albums;
  final Set<MediaTypeFilter> filter;
  final Set<LentFilter> lentFilter;
  final String? search;

  const DashboardLoadedState(
    this.albums,
    this.search,
    this.filter,
    this.lentFilter,
  );
}

class DashboardEmptyState extends DashboardState {
  const DashboardEmptyState();
}

class DashboardErrorState extends DashboardState {
  final String errorMessage;

  const DashboardErrorState(
    this.errorMessage,
  );
}
