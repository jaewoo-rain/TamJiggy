// calendar_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calender_event.dart';
import 'calender_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc()
      : super(const CalendarState(showCalendar: true, selectedDays: {})) {
    on<CalendarDaySelected>(_onDaySelected);
    on<CalendarSubmit>(_onSubmit);
    on<CalendarReset>(_onReset);
  }

  void _onDaySelected(CalendarDaySelected event, Emitter<CalendarState> emit) {
    final selectedDays = Set<DateTime>.from(state.selectedDays);
    // 이미 선택된 날짜면 제거, 아니면 추가 (TableCalendar의 isSameDay() 사용)
    final alreadySelected =
        selectedDays.any((d) => isSameDay(d, event.selectedDay));
    if (alreadySelected) {
      selectedDays.removeWhere((d) => isSameDay(d, event.selectedDay));
    } else {
      selectedDays.add(event.selectedDay);
    }
    emit(state.copyWith(selectedDays: selectedDays));
  }

  void _onSubmit(CalendarSubmit event, Emitter<CalendarState> emit) {
    emit(state.copyWith(showCalendar: false));
  }

  void _onReset(CalendarReset event, Emitter<CalendarState> emit) {
    emit(state.copyWith(showCalendar: true, selectedDays: {}));
  }
}
