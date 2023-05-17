part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {
  const WishlistEvent();
}

class WishlistLoadEvent extends WishlistEvent {
  const WishlistLoadEvent();
}

class WishlistDeleteAlbumEvent extends WishlistEvent {
  final Album selectedAlbum;

  const WishlistDeleteAlbumEvent(this.selectedAlbum);
}

class WishlistRefreshEvent extends WishlistEvent {
  final bool? reload;

  const WishlistRefreshEvent(this.reload);
}

class WishlistSearchAlbumEvent extends WishlistEvent {
  final String search;

  const WishlistSearchAlbumEvent(this.search);
}

class WishlistFilterAlbumEvent extends WishlistEvent {
  final Set<MediaTypeFilter> filter;
  final Set<LentFilter> lentFilter;

  const WishlistFilterAlbumEvent(this.filter, this.lentFilter);
}

class WishlistScrollAlbumListEvent extends WishlistEvent {
  final bool atEdge;

  const WishlistScrollAlbumListEvent(this.atEdge);
}
