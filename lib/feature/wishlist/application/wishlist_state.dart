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

  const WishlistLoadedState(
    this.albums,
    this.search,
    this.filter,
    this.lentFilter,
  );
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
