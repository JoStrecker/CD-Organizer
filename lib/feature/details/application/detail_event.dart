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
  const DetailDeleteEvent();
}

class DetailLendEvent extends DetailEvent{
  final String lendee;

  const DetailLendEvent(this.lendee);
}

class DetailGotBackEvent extends DetailEvent{
  const DetailGotBackEvent();
}
