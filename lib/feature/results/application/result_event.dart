part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {
  const ResultEvent();
}

class ResultLoadEvent extends ResultEvent {
  final List<Release> result;

  const ResultLoadEvent(
    this.result,
  );
}

class ResultSelectAlbumEvent extends ResultEvent {
  final Release selectedAlbum;

  const ResultSelectAlbumEvent(
    this.selectedAlbum,
  );
}
