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
  final ScrollController controller;
  final bool isAtTop;

  const DashboardLoadedState(
    this.albums,
    this.search,
    this.filter,
    this.lentFilter,
    this.controller,
    this.isAtTop,
  );

  DashboardLoadedState copyWith({
    List<Album>? albums,
    Set<MediaTypeFilter>? filter,
    Set<LentFilter>? lentFilter,
    String? search,
    ScrollController? controller,
    bool? isAtTop,
  }) {
    return DashboardLoadedState(
      albums ?? this.albums,
      search,
      filter ?? this.filter,
      lentFilter ?? this.lentFilter,
      controller ?? this.controller,
      isAtTop ?? this.isAtTop,
    );
  }
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
