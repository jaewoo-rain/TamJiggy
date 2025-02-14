// people_select_state.dart
import 'package:equatable/equatable.dart';

class PeopleSelectState extends Equatable {
  final int peopleCount;
  const PeopleSelectState({required this.peopleCount});
  PeopleSelectState copyWith({int? peopleCount}) {
    return PeopleSelectState(peopleCount: peopleCount ?? this.peopleCount);
  }

  @override
  List<Object?> get props => [peopleCount];
}
