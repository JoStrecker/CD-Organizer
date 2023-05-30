part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {
  const ResultEvent();
}

class ResultLoadEvent extends ResultEvent {
  final List<Release> result;
  final String query;

  const ResultLoadEvent(
    this.result,
    this.query,
  );
}

class ResultSelectAlbumEvent extends ResultEvent {
  final Release selectedAlbum;
  final bool wishlist;

  const ResultSelectAlbumEvent(
    this.selectedAlbum,
    this.wishlist,
  );
}

class ResultAddAlbumsEvent extends ResultEvent {
  const ResultAddAlbumsEvent();
}
