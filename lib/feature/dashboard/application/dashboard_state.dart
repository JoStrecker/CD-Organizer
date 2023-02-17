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
  final List<Release> albums;

  const DashboardLoadedState(
    this.albums,
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
