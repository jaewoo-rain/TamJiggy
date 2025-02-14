// map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_bloc.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  // 예시 데이터 (상수)
  final List<String> provinces = const ["서울", "경기"];

  final Map<String, List<String>> provinceToCities = const {
    "서울": ["강남구", "강동구", "종로구", "서초구", "ㄱ구", "ㄴ구", "ㄷ구", "ㄹ구"],
    "경기": ["수원시", "고양시", "용인시"],
  };

  final Map<String, List<String>> cityToNeighborhoods = const {
    "강남구": ["신사동", "압구정동", "청담동"],
    "강동구": ["암사동", "길동"],
    "종로구": ["사직동", "가회동"],
    "서초구": ["반포동", "서초동"],
    "수원시": ["영통동", "권선동", "장안동"],
    "고양시": ["일산동", "일산서"],
    "용인시": ["기흥동", "처인동"],
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(),
      child: BlocListener<MapBloc, MapState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            // SnackBar 표시 후 에러 메시지 클리어
            context.read<MapBloc>().add(const MapClearError());
          }
        },
        child: _MapPageContent(
          provinces: provinces,
          provinceToCities: provinceToCities,
          cityToNeighborhoods: cityToNeighborhoods,
        ),
      ),
    );
  }
}

class _MapPageContent extends StatelessWidget {
  final List<String> provinces;
  final Map<String, List<String>> provinceToCities;
  final Map<String, List<String>> cityToNeighborhoods;

  const _MapPageContent({
    Key? key,
    required this.provinces,
    required this.provinceToCities,
    required this.cityToNeighborhoods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // 화면 높이의 70%
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        // 상단 모서리 둥글게 처리
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          // 상단 고정 영역: 닫기(x) 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          // 메인 선택 영역: 시․도, 시․구․군, 동․읍․면
          Expanded(
            child: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                // 선택한 시․도에 따른 시․구․군 목록
                List<String> cities = state.selectedProvince != null
                    ? (provinceToCities[state.selectedProvince] ?? [])
                    : [];
                // 선택한 시․구․군에 따른 동․읍․면 목록
                List<String> neighborhoods = state.selectedCity != null
                    ? (cityToNeighborhoods[state.selectedCity] ?? [])
                    : [];

                return Row(
                  children: [
                    // 1. 시․도 목록
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "시․도",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: provinces.length,
                              itemBuilder: (context, index) {
                                final province = provinces[index];
                                bool isSelected =
                                    province == state.selectedProvince;
                                return ListTile(
                                  title: Text(
                                    province,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                  selected: isSelected,
                                  selectedTileColor: Colors.blue.shade100,
                                  onTap: () {
                                    context
                                        .read<MapBloc>()
                                        .add(MapProvinceSelected(province));
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    // 2. 시․구․군 목록
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "시․구․군",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: state.selectedProvince == null
                                ? const Center(child: Text("시․도를 선택하세요"))
                                : ListView.builder(
                                    itemCount: cities.length,
                                    itemBuilder: (context, index) {
                                      final city = cities[index];
                                      bool isSelected =
                                          city == state.selectedCity;
                                      return ListTile(
                                        title: Text(
                                          city,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.blue
                                                : Colors.black,
                                          ),
                                        ),
                                        selected: isSelected,
                                        selectedTileColor: Colors.blue.shade100,
                                        onTap: () {
                                          context
                                              .read<MapBloc>()
                                              .add(MapCitySelected(city));
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    // 3. 동․읍․면 목록 (다중 선택)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "동․읍․면",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: state.selectedCity == null
                                ? const Center(child: Text("시․구․군을 선택하세요"))
                                : ListView.builder(
                                    itemCount: neighborhoods.length,
                                    itemBuilder: (context, index) {
                                      final neighborhood = neighborhoods[index];
                                      bool isSelected = state
                                          .selectedNeighborhoods
                                          .contains(neighborhood);
                                      return ListTile(
                                        title: Text(
                                          neighborhood,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.blue
                                                : Colors.black,
                                          ),
                                        ),
                                        selected: isSelected,
                                        selectedTileColor: Colors.blue.shade100,
                                        onTap: () {
                                          context.read<MapBloc>().add(
                                              MapNeighborhoodToggled(
                                                  neighborhood));
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // 하단 고정 영역: 선택된 동․읍․면이 있을 때만 표시 (Chip 목록 및 "다음" 버튼)
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              if (state.selectedNeighborhoods.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                height: 100,
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue.shade100,
                child: Stack(
                  children: [
                    // Chip 목록 (좌우 스크롤, 최신 항목이 좌측에 표시)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: state.selectedNeighborhoods
                              .toList()
                              .reversed
                              .map(
                                (n) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Chip(
                                    label: Text(n),
                                    onDeleted: () {
                                      context
                                          .read<MapBloc>()
                                          .add(MapNeighborhoodToggled(n));
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    // "다음" 버튼 (항상 우측 하단에 배치)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("선택된 동․읍․면"),
                              content:
                                  Text(state.selectedNeighborhoods.join(', ')),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("확인"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text("다음"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
