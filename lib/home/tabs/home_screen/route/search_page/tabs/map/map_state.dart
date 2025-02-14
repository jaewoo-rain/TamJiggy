// map_state.dart
import 'package:equatable/equatable.dart';

class MapState extends Equatable {
  /// 선택한 시․도 (null이면 미선택)
  final String? selectedProvince;

  /// 선택한 시․구․군 (null이면 미선택)
  final String? selectedCity;

  /// 선택한 동․읍․면 (최대 10개)
  final Set<String> selectedNeighborhoods;

  /// 에러 메시지 (예, 최대 선택 개수 초과 시)
  final String? errorMessage;

  const MapState({
    this.selectedProvince,
    this.selectedCity,
    this.selectedNeighborhoods = const {},
    this.errorMessage,
  });

  /// 에러 메시지는 기본값을 지정하지 않으므로 copyWith 호출 시 전달하지 않으면 null로 갱신됩니다.
  MapState copyWith({
    String? selectedProvince,
    String? selectedCity,
    Set<String>? selectedNeighborhoods,
    String? errorMessage,
  }) {
    return MapState(
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedNeighborhoods:
          selectedNeighborhoods ?? this.selectedNeighborhoods,
      errorMessage: errorMessage, // 전달하지 않으면 null (즉, 에러 클리어)
    );
  }

  @override
  List<Object?> get props =>
      [selectedProvince, selectedCity, selectedNeighborhoods, errorMessage];
}
