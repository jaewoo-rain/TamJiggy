import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tam_jiggy/home/home.dart';
import 'package:tam_jiggy/select_page/models/hashtags_model.dart';
import 'package:tam_jiggy/select_page/select_bloc.dart';
import 'package:tam_jiggy/select_page/select_event.dart';
import 'package:tam_jiggy/select_page/select_state.dart';

class SelectPage extends StatelessWidget {
  final HashtagsModel hashtagsModel = HashtagsModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildHeader(), // 헤더 UI
              _buildGridView(context), // 그리드 UI
              _buildNextButton(context), // 다음 버튼 UI
            ],
          ),
        ),
      ),
    );
  }

  /// 헤더 UI
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 0, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "뭐 좋아하나",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "맞춤형 여행가이드를 소개해 드릴게요!",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// 중간 UI
  Widget _buildGridView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 560, // 고정된 높이 설정
        child: BlocBuilder<SelectBloc, SelectState>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: hashtagsModel.hashtags.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<SelectBloc>().add(ToggleHashtag(index));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          hashtagsModel.hashtags[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: state.selected[index]
                              ? Colors.blue
                              : Colors.grey[300],
                          border: Border.all(
                            color: state.selected[index]
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: state.selected[index]
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 다음 버튼 UI
  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<SelectBloc>().add(SaveHashtag(hashtagsModel.hashtags));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHomePage()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            // side: BorderSide(width: 3, color: Colors.blueAccent), // 테두리 두께 및 색상
            borderRadius: BorderRadius.circular(10), // 모서리 둥글기
          ),
        ),
        child: Text(
          "다음",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
