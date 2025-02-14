// map_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<MapProvinceSelected>(_onProvinceSelected);
    on<MapCitySelected>(_onCitySelected);
    on<MapNeighborhoodToggled>(_onNeighborhoodToggled);
    on<MapClearError>(_onClearError);
  }

  void _onProvinceSelected(MapProvinceSelected event, Emitter<MapState> emit) {
    // 시․도 선택 시 하위 시․구․군은 초기화 (동․읍․면은 그대로 유지)
    emit(state.copyWith(
      selectedProvince: event.province,
      selectedCity: null,
      // errorMessage를 전달하지 않으면 null이 되어 에러 메시지가 클리어됨
    ));
  }

  void _onCitySelected(MapCitySelected event, Emitter<MapState> emit) {
    emit(state.copyWith(
      selectedCity: event.city,
    ));
  }

  void _onNeighborhoodToggled(
      MapNeighborhoodToggled event, Emitter<MapState> emit) {
    final currentSelections = Set<String>.from(state.selectedNeighborhoods);
    if (currentSelections.contains(event.neighborhood)) {
      currentSelections.remove(event.neighborhood);
      emit(state.copyWith(selectedNeighborhoods: currentSelections));
    } else {
      if (currentSelections.length < 10) {
        currentSelections.add(event.neighborhood);
        emit(state.copyWith(selectedNeighborhoods: currentSelections));
      } else {
        print("꽉참");
        // 최대 10개 초과 시 에러 메시지 포함 상태 방출
        emit(state.copyWith(
          selectedNeighborhoods: currentSelections,
          errorMessage: "최대 10개까지 선택 가능합니다.",
        ));
      }
    }
  }

  void _onClearError(MapClearError event, Emitter<MapState> emit) {
    emit(state.copyWith(
      selectedNeighborhoods: state.selectedNeighborhoods,
      errorMessage: null,
    ));
  }
}
