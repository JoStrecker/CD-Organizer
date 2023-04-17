part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {
  const DetailEvent();
}

class DetailLoadEvent extends DetailEvent{
  final Album album;

  const DetailLoadEvent(this.album);
}

class DetailDeleteEvent extends DetailEvent{
  final BuildContext bc;

  const DetailDeleteEvent(this.bc);
}

class DetailLendEvent extends DetailEvent{
  final String lendee;

  const DetailLendEvent(this.lendee);
}
