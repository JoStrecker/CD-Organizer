part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {
  const ResultEvent();
}

class ResultLoadEvent extends ResultEvent {
  const ResultLoadEvent();
}

class ResultSelectAlbumEvent extends ResultEvent {
  final Release selectedAlbum;

  const ResultSelectAlbumEvent(
    this.selectedAlbum,
  );
}
