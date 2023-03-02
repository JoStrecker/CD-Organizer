part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object?> get props => [];
}

class SearchResultState extends SearchState {
  final List<Release> results;

  const SearchResultState(this.results);

  @override
  List<Object?> get props => [results];
}

class SearchEmptyState extends SearchState {
  const SearchEmptyState();

  @override
  List<Object?> get props => [];
}
