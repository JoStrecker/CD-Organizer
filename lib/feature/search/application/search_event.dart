part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchChangedEvent extends SearchEvent {
  final String text;
  const SearchChangedEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class SearchDeleteEvent extends SearchEvent {
  const SearchDeleteEvent();

  @override
  List<Object?> get props => [];
}

// class SearchFilterEvent extends SearchEvent {
//   final List<ElementType> searchFilter;
//
//   const SearchFilterEvent(this.searchFilter);
//
//   @override
//   List<Object?> get props => [searchFilter];
// }
