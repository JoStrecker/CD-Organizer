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
  final double? price;

  const DetailLoadedState(this.album, {this.price});

  DetailLoadedState copyWith({
    Album? album,
    double? price,
  }) {
    return DetailLoadedState(
      album ?? this.album,
      price: price ?? this.price,
    );
  }
}

class DetailErrorState extends DetailState {
  final String message;

  const DetailErrorState(this.message);
}
