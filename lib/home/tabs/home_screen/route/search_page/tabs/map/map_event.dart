// map_event.dart
import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

/// 시․도 선택 이벤트
class MapProvinceSelected extends MapEvent {
  final String province;
  const MapProvinceSelected(this.province);

  @override
  List<Object?> get props => [province];
}

/// 시․구․군 선택 이벤트
class MapCitySelected extends MapEvent {
  final String city;
  const MapCitySelected(this.city);

  @override
  List<Object?> get props => [city];
}

/// 동․읍․면 선택/해제 이벤트 (다중 선택, 최대 10개)
class MapNeighborhoodToggled extends MapEvent {
  final String neighborhood;
  const MapNeighborhoodToggled(this.neighborhood);

  @override
  List<Object?> get props => [neighborhood];
}

/// 에러 메시지(예, 최대 선택 개수 초과) 클리어 이벤트
class MapClearError extends MapEvent {
  const MapClearError();
}
