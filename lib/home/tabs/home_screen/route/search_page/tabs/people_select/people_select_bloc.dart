// people_select_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'people_select_event.dart';
import 'people_select_state.dart';

class PeopleSelectBloc extends Bloc<PeopleSelectEvent, PeopleSelectState> {
  PeopleSelectBloc() : super(const PeopleSelectState(peopleCount: 2)) {
    on<PeopleIncrement>((event, emit) {
      final newCount = state.peopleCount + 1;
      print('Incrementing people count: $newCount'); // 디버깅용 출력
      emit(state.copyWith(peopleCount: newCount));
    });

    on<PeopleDecrement>((event, emit) {
      if (state.peopleCount > 1) {
        final newCount = state.peopleCount - 1;
        print('Decrementing people count: $newCount'); // 디버깅용 출력
        emit(state.copyWith(peopleCount: newCount));
      }
    });
  }
}
