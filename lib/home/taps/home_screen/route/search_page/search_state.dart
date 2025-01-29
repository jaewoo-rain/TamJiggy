import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<String> recentSearches;
  final List<String> trendingSearches;
  final String currentQuery; // 현재 검색창에 입력된 검색어

  SearchLoaded(
      {required this.recentSearches,
      required this.trendingSearches,
      required this.currentQuery});

  @override
  List<Object> get props => [recentSearches, trendingSearches, currentQuery];
}
