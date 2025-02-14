// calendar_state.dart
import 'package:equatable/equatable.dart';

class CalendarState extends Equatable {
  /// 캘린더 화면을 보여줄 것인지, 선택한 날짜 목록 화면을 보여줄 것인지
  final bool showCalendar;

  /// 선택한 날짜들
  final Set<DateTime> selectedDays;

  const CalendarState({
    required this.showCalendar,
    required this.selectedDays,
  });

  CalendarState copyWith({
    bool? showCalendar,
    Set<DateTime>? selectedDays,
  }) {
    return CalendarState(
      showCalendar: showCalendar ?? this.showCalendar,
      selectedDays: selectedDays ?? this.selectedDays,
    );
  }

  @override
  List<Object?> get props => [showCalendar, selectedDays];
}
