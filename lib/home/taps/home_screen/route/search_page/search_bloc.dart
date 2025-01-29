import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<String> recentSearches = ["한국, 강원도 영월", "서울"]; // 초기 검색어
  List<String> trendingSearches = ["전주", "전주 한옥마을"]; // 트렌딩 검색어
  String currentQuery = ""; // 검색창의 현재 텍스트

  SearchBloc()
      : super(SearchLoaded(
            recentSearches: ["한국, 강원도 영월", "서울"], // 초기 최근 검색어 유지
            trendingSearches: ["전주", "전주 한옥마을"], // 초기 검색 순위 유지
            currentQuery: "")) {
    on<AddSearchEvent>((event, emit) {
      if (!recentSearches.contains(event.query)) {
        recentSearches.insert(0, event.query); // 중복 방지 후 최근 검색어 추가
      }
      emit(SearchLoaded(
          recentSearches: List.from(recentSearches),
          trendingSearches: List.from(trendingSearches), // 검색 순위 유지
          currentQuery: event.query)); // 검색창 업데이트
    });

    on<RemoveSearchEvent>((event, emit) {
      recentSearches.remove(event.query);
      emit(SearchLoaded(
          recentSearches: List.from(recentSearches),
          trendingSearches: List.from(trendingSearches), // 검색 순위 유지
          currentQuery: "")); // 검색어 초기화
    });

    on<ClearAllSearchEvent>((event, emit) {
      recentSearches.clear();
      emit(SearchLoaded(
          recentSearches: [], // 최근 검색어 전체 삭제
          trendingSearches: List.from(trendingSearches), // 검색 순위 유지
          currentQuery: ""));
    });

    on<UpdateSearchQueryEvent>((event, emit) {
      emit(SearchLoaded(
          recentSearches: List.from(recentSearches), // 최근 검색어 유지
          trendingSearches: List.from(trendingSearches), // 검색 순위 유지
          currentQuery: event.query)); // 검색창 텍스트만 변경
    });
  }
}
