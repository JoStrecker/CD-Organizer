part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {
  const WishlistState();
}

class WishlistInitialState extends WishlistState {
  const WishlistInitialState();
}

class WishlistLoadingState extends WishlistState {
  const WishlistLoadingState();
}

class WishlistLoadedState extends WishlistState {
  final List<Album> albums;
  final Set<MediaTypeFilter> filter;
  final Set<LentFilter> lentFilter;
  final String? search;
  final ScrollController controller;
  final bool isAtTop;

  const WishlistLoadedState(
    this.albums,
    this.search,
    this.filter,
    this.lentFilter,
    this.controller,
    this.isAtTop,
  );

  WishlistLoadedState copyWith({
    List<Album>? albums,
    Set<MediaTypeFilter>? filter,
    Set<LentFilter>? lentFilter,
    String? search,
    ScrollController? controller,
    bool? isAtTop,
  }) {
    return WishlistLoadedState(
      albums ?? this.albums,
      search,
      filter ?? this.filter,
      lentFilter ?? this.lentFilter,
      controller ?? this.controller,
      isAtTop ?? this.isAtTop,
    );
  }
}

class WishlistEmptyState extends WishlistState {
  const WishlistEmptyState();
}

class WishlistErrorState extends WishlistState {
  final String errorMessage;

  const WishlistErrorState(
    this.errorMessage,
  );
}
