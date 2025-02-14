// calendar_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'calender_bloc.dart';
import 'calender_event.dart';
import 'calender_state.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _firstDay;
  late DateTime _lastDay;

  // 애니메이션 컨트롤러 및 슬라이드 애니메이션
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 초기화 (300ms)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // 화면 아래에서 시작
      end: Offset.zero, // 제자리로 이동
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();

    // 날짜 지역화 초기화 (한국어)
    initializeDateFormatting('ko_KR', null);

    // 현재 달의 첫 날
    final now = DateTime.now();
    _firstDay = DateTime(now.year, now.month, 1);
    // 6개월치 달력을 보여주기 위해
    _lastDay = DateTime(_firstDay.year, _firstDay.month + 6, 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarBloc(),
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            // 상단 모서리 둥글게 처리
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 왼쪽 상단 닫기 버튼
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // 남은 영역에 캘린더 혹은 선택된 날짜 뷰 표시
                  Expanded(
                    child: BlocBuilder<CalendarBloc, CalendarState>(
                      builder: (context, state) {
                        return state.showCalendar
                            ? _buildCalendarView(context, state)
                            : _buildSelectedView(context, state);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 캘린더 선택 뷰: 여러 달을 ListView로 표시
  Widget _buildCalendarView(BuildContext context, CalendarState state) {
    final totalMonths = (_lastDay.year - _firstDay.year) * 12 +
        _lastDay.month -
        _firstDay.month +
        1;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: totalMonths,
            itemBuilder: (context, index) {
              final calendarMonth =
                  DateTime(_firstDay.year, _firstDay.month + index, 1);
              return Column(
                children: [
                  TableCalendar(
                    locale: 'ko_KR',
                    firstDay: _firstDay,
                    lastDay: _lastDay,
                    focusedDay: calendarMonth,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return state.selectedDays
                          .any((selectedDay) => isSameDay(selectedDay, day));
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      context
                          .read<CalendarBloc>()
                          .add(CalendarDaySelected(selectedDay));
                    },
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      weekendTextStyle: TextStyle(color: Colors.red),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
        // '선택' 버튼
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.read<CalendarBloc>().add(const CalendarSubmit());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '선택',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  /// 선택된 날짜들을 보여주는 뷰
  Widget _buildSelectedView(BuildContext context, CalendarState state) {
    final selectedDates = state.selectedDays.toList()
      ..sort((a, b) => a.compareTo(b));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '선택된 일정',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: selectedDates.isNotEmpty
              ? ListView.builder(
                  itemCount: selectedDates.length,
                  itemBuilder: (context, index) {
                    final date = selectedDates[index];
                    return Text(
                      '${date.year}-${date.month}-${date.day}',
                      style: const TextStyle(fontSize: 16),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    '선택된 일정이 없습니다.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<CalendarBloc>().add(const CalendarReset());
            },
            child: const Text('다시 선택하기'),
          ),
        ),
      ],
    );
  }
}
