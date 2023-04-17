part of 'detail_bloc.dart';

@immutable
abstract class DetailState {
  const DetailState();
}

class DetailInitialState extends DetailState {
  const DetailInitialState();
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState();
}

class DetailLoadedState extends DetailState {
  final Album album;

  const DetailLoadedState(this.album);
}

class DetailErrorState extends DetailState {
  final String message;

  const DetailErrorState(this.message);
}
