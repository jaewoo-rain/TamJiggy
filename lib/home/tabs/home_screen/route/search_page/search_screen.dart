import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/search_bloc.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/search_event.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/search_state.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/tabs/calender/calender_page.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/tabs/map/map_page.dart';
import 'package:tam_jiggy/home/tabs/home_screen/route/search_page/tabs/people_select/people_select_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void showBottomSheet(BuildContext context, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: content,
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          backgroundColor: Color(0xFF4485FF),
          titleSpacing: 0,
          leadingWidth: 40,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                _searchController.text = state.currentQuery; // 검색창 업데이트
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 12, right: 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "여행하고 싶은 곳이 있나요?",
                    ),
                    onChanged: (value) {
                      context
                          .read<SearchBloc>()
                          .add(UpdateSearchQueryEvent(value));
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue[100],
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => CalendarPage(),
                  ),
                  icon: Icon(Icons.calendar_today),
                  label: Text("일정"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                // PeopleSelectWidget를 바텀시트로 호출
                ElevatedButton.icon(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => PeopleSelectPage(),
                  ),
                  icon: Icon(Icons.person),
                  label: Text("인원 선택"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                ElevatedButton.icon(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // 추가
                    builder: (context) => MapPage(), // 내부에서 높이를 지정하도록 수정
                  ),
                  icon: Icon(Icons.map),
                  label: Text("지도보기"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoaded) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("최근 검색어",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold)),
                            if (state.recentSearches.isNotEmpty)
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(ClearAllSearchEvent());
                                },
                                child: Text("모두 지우기",
                                    style: TextStyle(color: Colors.red)),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.recentSearches.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.recentSearches[index],
                                  style: TextStyle(fontSize: 20)),
                              trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  context.read<SearchBloc>().add(
                                      RemoveSearchEvent(
                                          state.recentSearches[index]));
                                },
                              ),
                              onTap: () {
                                context.read<SearchBloc>().add(
                                    UpdateSearchQueryEvent(
                                        state.recentSearches[index]));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
