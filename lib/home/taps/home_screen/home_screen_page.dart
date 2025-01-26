import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tam_jiggy/home/taps/home_screen/home_screen_bloc.dart';
import 'package:tam_jiggy/home/taps/home_screen/home_screen_event.dart';
import 'package:tam_jiggy/home/taps/home_screen/home_screen_state.dart';
import 'package:tam_jiggy/home/taps/home_screen/widgets/profile_card.dart';
import 'package:tam_jiggy/home/taps/home_screen/widgets/review_card.dart';
import 'package:tam_jiggy/home/taps/home_screen/widgets/search_bar.dart';
import 'package:tam_jiggy/home/taps/home_screen/widgets/travel_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc()..add(LoadReviews()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 상단 파란 배경+검색바
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 16 + 16 + 50,
                    color: Color(0xFF4485FF),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TravelSearchBar(),
                  ),
                ],
              ),

              // 인기 여행지 섹션
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "인기 여행지",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          TravelCard(
                            title: "맛집 투어",
                            imagePath: "assets/images/jbnu.jpg",
                            subtitle: "가이드 업댓 사진",
                            location: "케이크와 같은 밤",
                            views: 1234,
                            likes: 15,
                          ),
                          TravelCard(
                            title: "전북대 투어",
                            imagePath: "assets/images/jbnu.jpg",
                            subtitle: "가이드 업댓 사진",
                            location: "오프로드",
                            views: 1234,
                            likes: 0,
                          ),
                          TravelCard(
                            title: "한옥마을 투어",
                            imagePath: "assets/images/jbnu.jpg",
                            subtitle: "가이드 업댓 사진",
                            location: "오프로드",
                            views: 1234,
                            likes: 0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "여행지기를 소개합니다:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 265,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ProfileCard(
                            imagePath: "assets/images/profile.jpg",
                            name: '1번',
                            info: '1번은 1번이다',
                          ),
                          ProfileCard(
                            imagePath: "assets/images/profile.jpg",
                            name: '2번',
                            info: '2번은 2번이다 ddpdppddpddpdpdpdpp...',
                          ),
                          ProfileCard(
                            imagePath: "assets/images/profile.jpg",
                            name: '3번',
                            info: '3번은 3번이다 33333333ㅇㅇㅇ...',
                          ),
                          ProfileCard(
                            imagePath: "assets/images/profile.jpg",
                            name: '4번',
                            info: '4번은 5번 보다 작다',
                          ),
                          ProfileCard(
                            imagePath: "assets/images/profile.jpg",
                            name: '5번',
                            info: '5번은 가장 크다',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              // 리뷰 섹션
              Text(
                "리뷰",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
                  if (state is ReviewState) {
                    if (state.reviews.isEmpty) {
                      return Text("리뷰 데이터가 없습니다.");
                    }

                    // Masonry 레이아웃
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: MasonryGridView.count(
                        // MasonryGridView는 내부적으로 스크롤하므로,
                        // SingleChildScrollView와 함께 사용할 경우 설정 필요:
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        crossAxisCount: 2, // 2열
                        mainAxisSpacing: 16, // 위아래 간격
                        crossAxisSpacing: 16, // 좌우 간격

                        itemCount: state.reviews.length,
                        itemBuilder: (context, index) {
                          final review = state.reviews[index];
                          return ReviewCard(
                            image: review["image"],
                            title: review["title"],
                            author: review["author"],
                            views: review["views"],
                            likes: review["likes"],
                          );
                        },
                      ),
                    );
                  }

                  // 로딩 상태
                  if (state is TravelInitial) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // 에러 등
                  return Center(
                    child: Text(
                      "리뷰를 불러오지 못했습니다.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
