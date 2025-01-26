import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tam_jiggy/home/taps/home_screen/home_screen_event.dart';
import 'package:tam_jiggy/home/taps/home_screen/home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(TravelInitial()) {
    on<LoadTravelData>(_onLoadTravelData);
    on<LoadReviews>(_onLoadReviews);
  }

  void _onLoadTravelData(LoadTravelData event, Emitter<HomeScreenState> emit) {
    // 여행 데이터 로드 로직 (예: API 호출 또는 로컬 데이터 로드)
    emit(TravelLoaded());
  }

  void _onLoadReviews(LoadReviews event, Emitter<HomeScreenState> emit) {
    final reviews = [
      {
        "image": "assets/images/review1.jpg",
        "title": "전주에서 즐거웠던 기억!",
        "author": "밥먹은 케이크",
        "views": 1234,
        "likes": 15,
      },
      {
        "image": "assets/images/review2.jpg",
        "title": "동대문구에는 내가 살아요",
        "author": "밥먹은 케이크",
        "views": 1234,
        "likes": 15,
      },
      {
        "image": "assets/images/review3.jpg",
        "title": "언젠가는 집에 가겠지",
        "author": "밥먹은 케이크",
        "views": 10000,
        "likes": 1000,
      },
      {
        "image": "assets/images/review4.jpg",
        "title": "집가고 싶다",
        "author": "밥먹은 케이크",
        "views": 8000,
        "likes": 15,
      },
      {
        "image": "assets/images/review4.jpg",
        "title": "집가고 싶다",
        "author": "밥먹은 케이크",
        "views": 8000,
        "likes": 15,
      },
    ];
    // ReviewState로 상태 전환
    emit(ReviewState(reviews));
  }
}
