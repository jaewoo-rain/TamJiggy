// calendar_event.dart
import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

/// 날짜 선택/해제 이벤트
class CalendarDaySelected extends CalendarEvent {
  final DateTime selectedDay;

  const CalendarDaySelected(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}

/// '선택' 버튼을 눌러 캘린더 뷰를 제출하는 이벤트
class CalendarSubmit extends CalendarEvent {
  const CalendarSubmit();
}

/// '다시 선택하기' 버튼을 눌러 선택 상태를 초기화하는 이벤트
class CalendarReset extends CalendarEvent {
  const CalendarReset();
}
