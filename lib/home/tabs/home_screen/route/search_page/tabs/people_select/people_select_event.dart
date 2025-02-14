// people_select_event.dart
import 'package:equatable/equatable.dart';

abstract class PeopleSelectEvent extends Equatable {
  const PeopleSelectEvent();
  @override
  List<Object?> get props => [];
}

class PeopleIncrement extends PeopleSelectEvent {
  const PeopleIncrement();
}

class PeopleDecrement extends PeopleSelectEvent {
  const PeopleDecrement();
}
